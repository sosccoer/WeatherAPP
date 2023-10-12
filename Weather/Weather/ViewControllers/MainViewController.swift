//
//  MainViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import UIKit



enum WeatherRequestPath: String {
    case forecastWeather = "/forecast.json"
}

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
        
        guard let forecast = lastRespons?.forecastWeather.forecastDay else { return }
        
        self.cellsForHoursAndTemperatureCell = [
            
            CelsiumAndHoursModel(time: forecast[0].hour[0].time, temperature: forecast[0].hour[0].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[1].time, temperature: forecast[0].hour[1].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[2].time, temperature: forecast[0].hour[2].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[3].time, temperature: forecast[0].hour[3].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[4].time, temperature: forecast[0].hour[4].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[5].time, temperature: forecast[0].hour[5].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[6].time, temperature: forecast[0].hour[6].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[7].time, temperature: forecast[0].hour[7].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[8].time, temperature: forecast[0].hour[8].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[9].time, temperature: forecast[0].hour[9].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[10].time, temperature: forecast[0].hour[10].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[11].time, temperature: forecast[0].hour[11].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[12].time, temperature: forecast[0].hour[12].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[13].time, temperature: forecast[0].hour[13].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[14].time, temperature: forecast[0].hour[14].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[15].time, temperature: forecast[0].hour[15].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[16].time, temperature: forecast[0].hour[16].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[17].time, temperature: forecast[0].hour[17].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[18].time, temperature: forecast[0].hour[18].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[19].time, temperature: forecast[0].hour[19].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[20].time, temperature: forecast[0].hour[20].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[21].time, temperature: forecast[0].hour[21].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[22].time, temperature: forecast[0].hour[22].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[23].time, temperature: forecast[0].hour[23].temperatureInCelsium)
        
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
