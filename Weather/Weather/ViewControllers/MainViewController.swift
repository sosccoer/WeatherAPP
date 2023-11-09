//
//  MainViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import UIKit
import RxSwift
import RealmSwift
import CryptoKit



class MainViewController: UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    let refreshControl = UIRefreshControl()
    
    private let settings = Settings()
    
    private var cells: [MainCollectionViewModel] = []{
        didSet {
//            encodeCells()
        }
    }
        
     let viewModel = MainViewModel()
    
    private let disposedBag = DisposeBag()
    
    var cellsData = Data()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.makeWeather()
        
        refreshData()
        
        bindViewModel ()
        
        setupMainView()
        
        setupCollectionView ()
        
        readRealm()
        
    }
    
    private func encodeCells () {
        
        guard let realm = try? Realm() else {return}
        
        try? realm.write{
            
            realm.deleteAll()
            
        }
        
        var Data = Data()
        
        do {
            let jsonData = try JSONEncoder().encode(cells)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let data = jsonString.data(using: .utf8) {
                    Data = data
                }
            }
        } catch {
            print("Ошибка при кодировании в JSON: \(error)")
        }
        
        
        writeToRealm(Data: Data)
        
        //////////////////////////////////////////////////////////////////////////////
        
        
        
        
        
//        do {
//            if let data2 = Data1 {
//                let decodedData = try JSONDecoder().decode([cellsRealm].self, from: data2)
//                
//                for item in decodedData {
//                    print("Запись: \(item.field1), \(item.field2)")
//                    // Здесь вы можете обрабатывать извлеченные данные
//                }
//            }
//        } catch {
//            print("Ошибка при декодировании данных: \(error)")
//        }
        
        
        
    }
    
    func readRealm () {
        
        guard let realm = try? Realm() else {return}
        
//        let cellsRealm = MainCellsRealm()

        let objects = realm.objects(MainCellsRealm.self)
        
        for object in objects {
            
            decodeRealmData(data: object.mainCells)
            
        }
        
    }
    
    private func decodeRealmData(data: Data) {
        
        do {
            
            
            let cells = try? JSONDecoder().decode(MainCollectionViewModel.self, from: data)
            
            print("ВОТ ТАКИЕ ЯЧЕЙКИ ВЫШЛИ \(cells)")
            
            
        }catch {
            print(error)
        }
        
    }
    
    func writeToRealm(Data: Data){
        
        guard let realm = try? Realm() else {return}
        
        let cellsRealm = MainCellsRealm()
        
        cellsRealm.mainCells = Data
        cellsRealm.completed = true
        
        do {
            
                try realm.write {
                realm.add(cellsRealm)
                    
            }
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    private func bindViewModel () {
        
        viewModel.mainCellsObservable.subscribe(onNext: { [weak self] cells in
            
            self?.cells = cells
            self?.collectionView.reloadData()
            
        }).disposed(by: disposedBag)
        
        
    }
    
    
    private func setupMainView () {
        
        view.backgroundColor = UIColor(red: 135/255.0, green: 206/255.0, blue: 250/255.0, alpha: 1.0)
        
    }
    
    private func setupCollectionView () {
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        collectionView.addSubview(refreshControl)
        
        registerCells()
    }
    
    @objc private func refreshData() {
        
        viewModel.makeWeather()
        
        collectionView.reloadData()
        
        refreshControl.endRefreshing()
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        let destination = SettingsViewController()
        destination.settings = settings
        viewModel.settings = settings
        present(destination,animated: true)
        
    }
    
    private func registerCells (){
        
        let Hoursnib = UINib(nibName: "ForHoursAndCelsiumCellsCollectionViewCell", bundle: Bundle.main)
        collectionView.register(Hoursnib, forCellWithReuseIdentifier: "ForHoursAndCelsiumCellsCollectionViewCell")
        
        let squareNib = UINib(nibName: "ForSquareTableViewCollectionViewCell", bundle: Bundle.main)
        collectionView.register(squareNib, forCellWithReuseIdentifier: "ForSquareTableViewCollectionViewCell")
        
        let cityNib = UINib(nibName: "CityAndTemperatureCollectionViewCell", bundle: Bundle.main)
        collectionView.register(cityNib, forCellWithReuseIdentifier: "CityAndTemperatureCollectionViewCell")
        
    }
    
}

extension MainViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        let transparentColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.075)
        
        switch cells[index].type {
            
        case .CityAndTemperatureCollectionViewCell : guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CityAndTemperatureCollectionViewCell", for: indexPath) as? CityAndTemperatureCollectionViewCell else {return UICollectionViewCell()}
            
            cell.settingButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            cell.weatherCondition.text = viewModel.lastRespons?.currentWeather.condition.weatherText
//            info.condition.weatherText
            
            cell.nameOfCity.text = cells[index].nameOfSetting
            cell.temperature.text = cells[index].value
            
            return cell
            
        case .CelsiumAndHoursCollectionViewCell : guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForHoursAndCelsiumCellsCollectionViewCell", for: indexPath) as? ForHoursAndCelsiumCellsCollectionViewCell else {return UICollectionViewCell()}
            
            
            cell.viewModel = self.viewModel
            cell.layer.cornerRadius = 20
            cell.backgroundColor = transparentColor
            
            return cell
            
        case .ForSquareTableViewCollectionViewCell: guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForSquareTableViewCollectionViewCell", for: indexPath) as? ForSquareTableViewCollectionViewCell else {return UICollectionViewCell()}
            
            cell.layer.cornerRadius = 30
            cell.backgroundColor = transparentColor
            
            cell.nameOFSetting.text = cells[index].nameOfSetting
            cell.value.text = cells[index].value
            
            return cell
            
        }
        
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.row {
            
        case 0 : return CGSize(width: 377, height: 200)
            
        case 1 : return CGSize(width: 377, height: 110)
            
        case 2 ... 7 : return CGSize(width: 186, height: 186)
            
        default: return CGSize(width: 0, height: 0)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // Задайте ваше кастомное расстояние между ячейками
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5 // Здесь вы можете задать ваше кастомное вертикальное расстояние между строками (ячейками)
    }
    
}


