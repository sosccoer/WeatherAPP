//
//  MainViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    private let apiWeather = ApiWeather()
    
    var lastRespons: RealTimeWeatherRespons?
    
    let refreshControl = UIRefreshControl()
    
    private let cells: [MainCollectionViewModel] = [
        
        MainCollectionViewModel(type: .CityAndTemperatureCollectionViewCell),
        MainCollectionViewModel(type: .CelsiumAndHoursCollectionViewCell),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell)
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiWeather.makeCurrentWeather()
        setupMainView()
        apiWeather.delegate = self
        setupCollectionView ()
        
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
        
        apiWeather.makeCurrentWeather()
        refreshControl.endRefreshing()
        
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
            
            return cell
            
        case .CelsiumAndHoursCollectionViewCell : guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForHoursAndCelsiumCellsCollectionViewCell", for: indexPath) as? ForHoursAndCelsiumCellsCollectionViewCell else {return UICollectionViewCell()}
            cell.layer.cornerRadius = 20
            cell.backgroundColor = transparentColor
            
            return cell
            
        case .ForSquareTableViewCollectionViewCell: guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForSquareTableViewCollectionViewCell", for: indexPath) as? ForSquareTableViewCollectionViewCell else {return UICollectionViewCell()}
            
            cell.layer.cornerRadius = 30
            cell.backgroundColor = transparentColor

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

extension MainViewController: WeatherAPIDelegate {
    
    func gotRealTimeWeather(respons: RealTimeWeatherRespons) {
        
        lastRespons = respons
    }
    
    func gotError(description: String) {
        
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    
}
