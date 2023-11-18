//
//  MainCellsViewModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.10.23.
//

import Foundation
import UIKit
import RxSwift
import RealmSwift



class MainViewModel {
    
    private let mainCellsSubject = PublishSubject<[MainCollectionViewModel]>()
    private let hoursAndTemperatureCellSubject = PublishSubject<[CelsiumAndHoursModel]>()
    
    let mainCellsObservable: Observable<[MainCollectionViewModel]>
    let hoursAndTemperatureObservable: Observable<[CelsiumAndHoursModel]>
    
    let realm = try? Realm()
    
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
    
    var cellsForRealm: [MainCollectionViewModel]! {
        
        didSet {
            encodeCells()
        }
        
    }
    
    private let adapter = SettingAdapter()
    
    var settings = Settings()
    
    private let apiWeather = ApiWeather()
        
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
        
        let cells = [
            
            MainCollectionViewModel(type: .CityAndTemperatureCollectionViewCell,nameOfSetting: location.cityName ,value: adapter.getTemperature(for: info, with: settings)),
            
            MainCollectionViewModel(type: .CelsiumAndHoursCollectionViewCell,nameOfSetting: "Ощущается как",value: adapter.getTemperature(for: info, with: settings) ),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Ощущается как",value: adapter.getFeelsLikeTemperature(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Скорость ветра",value: adapter.getWindVelocity(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Давление",value: adapter.getPressure(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Видимость",value: adapter.getVisible(for: info, with: settings)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "УФ-Индекс",value: String(info.uvFactor)),
            
            MainCollectionViewModel(type: .ForSquareTableViewCollectionViewCell,nameOfSetting: "Скорость порывов",value: adapter.getGustVelocity(for: info, with: settings))
            
        ]
        
        mainCellsSubject.onNext(cells)
        
        
    }
    
    func updateValuesForHoursAndTemperatureCell() {
        guard let forecast = lastRespons?.forecastWeather else { return }
        
        let dispatchGroup = DispatchGroup()
        
        let celsiumAndHoursModels = (0...23).map { index in
            let time = adapter.getTimeForHoursAndTemperatureCell(for: forecast, index: index)
            let temperature = adapter.getTemperatureForHoursAndTemperatureCell(for: forecast, with: settings, index: index)
            
            var image = UIImage()
            
            dispatchGroup.enter()
            adapter.getPictureAboutWeather(for: forecast, index: index) { (fetchedImage) in
                image = fetchedImage
                dispatchGroup.leave()
            }
            
            dispatchGroup.wait()
            
            return CelsiumAndHoursModel(time: time, temperature: temperature, image: image)
        }
        
        cellsForHoursAndTemperatureCell = celsiumAndHoursModels.sorted { $0.time < $1.time }
        hoursAndTemperatureCellSubject.onNext(cellsForHoursAndTemperatureCell)
    }
    
    private func encodeCells () {
        
        try? realm?.write{
            
            realm?.deleteAll()
            
        }
        
        var Data = Data()
        
        do {
            let jsonData = try JSONEncoder().encode(cellsForRealm)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let data = jsonString.data(using: .utf8) {
                    Data = data
                }
            }
        } catch {
            print("Ошибка при кодировании в JSON: \(error)")
        }
        
        
        writeToRealm(Data: Data)

    }
    
    func writeToRealm(Data: Data){
        
        let cellsRealm = MainCellsRealm()
        
        cellsRealm.mainCells = Data
        cellsRealm.completed = true
        
        do {
            
                try realm?.write {
                realm?.add(cellsRealm)
                    print("ВОТ ПО ЭТОМУ ПУТИ ИДЕТ СОХРАНЕНИЕ ",realm?.configuration.fileURL)
                    
            }
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func readRealm () {
        
        guard let realm = try? Realm() else {return}

        let objects = realm.objects(MainCellsRealm.self)
        
        for object in objects {
            
            decodeRealmData(data: object.mainCells)
            
        }
        
    }
    
    private func decodeRealmData(data: Data) {
        
        do {
            
            let cells = try JSONDecoder().decode([MainCollectionViewModel].self, from: data)
            
            mainCellsSubject.onNext(cells)
            
            
        } catch {
            print(error)
        }
        
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
