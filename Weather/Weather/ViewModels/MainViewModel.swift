//
//  MainCellsViewModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.10.23.
//

import Foundation
import UIKit
import RxSwift


class MainViewModel {
    
    private let mainCellsSubject = PublishSubject<[MainCollectionViewModel]>()
    private let hoursAndTemperatureCellSubject = PublishSubject<[CelsiumAndHoursModel]>()
    
    let mainCellsObservable: Observable<[MainCollectionViewModel]>
    let hoursAndTemperatureObservable: Observable<[CelsiumAndHoursModel]>
    
    init() {
        mainCellsObservable = mainCellsSubject.asObservable()
        hoursAndTemperatureObservable = hoursAndTemperatureCellSubject.asObservable()
    }
    
    var lastRespons: RealTimeWeatherRespons? {
        willSet {
            cellsForHoursAndTemperatureCell = []
        }
        didSet {
            updateValues()
            updateValuesForHoursAndTemperatureCell()
        }
    }
    
    private let adapter = SettingAdapter()
    
    private let settings = Settings()
    
    private let apiWeather = ApiWeather()
    
    var cells: [MainCollectionViewModel] = []
    
    var cellsForHoursAndTemperatureCell: [CelsiumAndHoursModel] = []{
        willSet {
            cellsForHoursAndTemperatureCell = []
        }
    }
    
    func makeWeather () {
        
        apiWeather.delegate = self
        apiWeather.makeCurrentWeather()
        
    }
    
    func updateValues ()  {
        
        guard let info = lastRespons?.currentWeather else{ return }
        guard let location = lastRespons?.currentLocation else { return }
        
        self.cells = [
            
            MainCollectionViewModel(type: .CityAndTemperatureCollectionViewCell,nameOfSetting: location.cityName ,value: adapter.getTemperature(for: info, with: settings)),
            
            MainCollectionViewModel(type: .CelsiumAndHoursCollectionViewCell,nameOfSetting: "Ощущается как",value: adapter.getTemperature(for: info, with: settings) ),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Ощущается как",value: adapter.getFeelsLikeTemperature(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Скорость ветра",value: adapter.getWindVelocity(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Давление",value: adapter.getPressure(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Видимость",value: adapter.getVisible(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "УФ-Индекс",value: String(info.uvFactor)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Скорость порывов",value: adapter.getGustVelocity(for: info, with: settings))
            
        ]
        
        mainCellsSubject.onNext(self.cells)
        
        updateValuesForHoursAndTemperatureCell()
        
    }
    
    func updateValuesForHoursAndTemperatureCell() {
        guard let forecast = lastRespons?.forecastWeather else { return }
        
        let dispatchGroup = DispatchGroup()
        
        let celsiumAndHoursModels = (0...23).map { index in
            let time = adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: index)
            let temperature = adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: index)
            
            var image = UIImage()
            
            dispatchGroup.enter()
            adapter.getPictureAboutWeather(for: forecast, index: index) { fetchedImage in
                image = fetchedImage
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
            
            return CelsiumAndHoursModel(time: time, temperature: temperature, image: image)
        }
        
        cellsForHoursAndTemperatureCell = celsiumAndHoursModels.sorted { $0.time < $1.time }
        hoursAndTemperatureCellSubject.onNext(cellsForHoursAndTemperatureCell)
    }
    
}

extension MainViewModel: WeatherAPIDelegate {
    
    func gotRealTimeWeather(respons: RealTimeWeatherRespons) {
        
        lastRespons = respons
        
    }
    
    func gotError(description: String) {
        
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        
    }
    
}
