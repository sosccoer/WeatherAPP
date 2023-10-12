//
//  MainViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import UIKit

class MainViewController: UIViewController  {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    private let apiWeather = ApiWeather()
    
    var lastRespons: RealTimeWeatherRespons?
    
    let refreshControl = UIRefreshControl()
    
    var cellsForHoursAndTemperatureCell: [CelsiumAndHoursModel] = []
    
    private let adapter = SettingAdapter()
    
    private let settings = Settings()
    
    private var cells: [MainCollectionViewModel] = [
        
        MainCollectionViewModel(type: .CityAndTemperatureCollectionViewCell,nameOfSetting: "",value: "" ),
        
        MainCollectionViewModel(type: .CelsiumAndHoursCollectionViewCell,nameOfSetting: "" ,value: ""),
        
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: " asd ",value: "fsfsd"),
        
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "это четвертая  ",value: "4"),
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: " ",value: ""),
        
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: " ",value: ""),
        
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: " ",value: ""),
        
        MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: " ",value: ""),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        apiWeather.delegate = self
        refreshData()
        
        setupMainView()
        
        updateValues()
        
        setupCollectionView ()
        
    }
    
    func updateValues ()  {
        
        guard let info = lastRespons?.currentWeather else{ return }
        guard let location = lastRespons?.currentLocation else { return }
        
        self.cells = [
            
            MainCollectionViewModel(type: .CityAndTemperatureCollectionViewCell,nameOfSetting: location.cityName ,value: adapter.getTemperature(for: info, with: settings) ),
            
            MainCollectionViewModel(type: .CelsiumAndHoursCollectionViewCell,nameOfSetting: "Ощущается как",value: adapter.getTemperature(for: info, with: settings) ),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Ощущается как",value: adapter.getFeelsLikeTemperature(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Скорость ветра",value: adapter.getWindVelocity(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Давление",value: adapter.getPressure(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Видимость",value: adapter.getVisible(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "УФ-Индекс",value: String(info.uvFactor)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Скорость порывов",value: adapter.getGustVelocity(for: info, with: settings))
            
        ]
        
        updateValuesForHoursAndTemperatureCell()
    }
    
    func updateValuesForHoursAndTemperatureCell () {
        
        guard let forecast = lastRespons?.forecastWeather else { return }
        
        self.cellsForHoursAndTemperatureCell = [
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 0), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 0)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 1), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 1)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 2), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 2)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 3), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 3)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 4), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 4)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 5), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 5)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 6), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 6)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 7), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 8)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 9), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 9)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 10), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 10)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 11), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 11)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 12), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 12)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 13), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 13)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 14), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 14)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 15), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 15)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 16), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 16)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 17), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 17)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 18), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 18)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 19), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 19)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 20), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 20)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 21), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 21)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 22), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 22)),
            
            CelsiumAndHoursModel(time: adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: 23), temperature: adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: 23))
            
        ]
        
        collectionView.reloadData()
        
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
        updateValues()
        collectionView.reloadData()
        refreshControl.endRefreshing()
        
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        
        let destination = SettingsViewController()
        destination.settings = settings
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
            
            cell.nameOfCity.text = cells[index].nameOfSetting
            cell.temperature.text = cells[index].value
            
            return cell
            
        case .CelsiumAndHoursCollectionViewCell : guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForHoursAndCelsiumCellsCollectionViewCell", for: indexPath) as? ForHoursAndCelsiumCellsCollectionViewCell else {return UICollectionViewCell()}
            cell.layer.cornerRadius = 20
            cell.backgroundColor = transparentColor
            cell.cells = self.cellsForHoursAndTemperatureCell
            
            cell.collectionView.reloadData()
            
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

extension MainViewController: WeatherAPIDelegate {
    
    func gotRealTimeWeather(respons: RealTimeWeatherRespons) {
        
        lastRespons = respons
        updateValues()
        
    }
    
    func gotError(description: String) {
        
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    
}
