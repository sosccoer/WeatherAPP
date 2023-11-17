//
//  SettingAdapter.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import Foundation
import UIKit
import Kingfisher

class SettingAdapter {
    
    private let mmHgCoefficient = 0.750063755419211
    
    func getPictureAboutWeather(for info: ForecastWeather , index: Int, handler:@escaping ((UIImage) -> ())) {
        let stringUrl = "https:\(String(info.forecastDay[0].hour[index].WeatherCondiation.photoOfWeather))"
        
        
        
        guard let URL = URL(string: stringUrl) else { handler(UIImage()); return}
        
        let imageView = UIImageView()
        
        imageView.kf.setImage(with: URL) { result in
            
            switch result {
            case .success(let value):
                print(value)
            case .failure(let error):
                print(error)
            }
            
        }
        
        handler(imageView.image ?? UIImage())
        
        
        
        
        
        
//        KingfisherManager.shared.retrieveImage(with: resources, completionHandler: handler) { result in
//            
//            switch result {
//                    case .success(let value):
//                        handler(value.image)
//                    case .failure(let error):
//                        print("Произошла ошибка при загрузке изображения: \(error)")
//                    }
//        }
        
        
        
        
//        DispatchQueue.global(qos: .userInitiated).async{
//            do {
//                let data = try Data(contentsOf: URL)
//                if let image = UIImage(data: data) {
//                    handler(image)
//                }
//            } catch {
//                print("Произошла ошибка при загрузке изображения: \(error)")
//            }
//        }
        
    }
    
    func getTimeForHoursAndTemperatureCell (for info: ForecastWeather, index:Int) -> String {
        
        return "\((String(info.forecastDay[0].hour[index].time).suffix(5)).prefix(2))H"
        
    }
    
    func getTemperatureForHoursAndTemperatureCell (for info: ForecastWeather,with settings: Settings,index: Int) -> String {
        
        switch settings.temperature {
            
        case .celsius:
            return "\(info.forecastDay[0].hour[index].temperatureInCelsium)\(TemperatureType.celsius.rawValue)"
        case .fahrenheit:
            return "\(info.forecastDay[0].hour[index].temperatureInFarenheit)\(TemperatureType.fahrenheit.rawValue)"
        }
        
    }
    
    func getTemperature(for info:CurrentWeather,with settings: Settings) -> String {
        
        switch settings.temperature {
        case .celsius:
            return "\(info.temperatureInCelsius)\(TemperatureType.celsius.rawValue)"
        case .fahrenheit:
            return "\(info.temperatureInFahrenheit)\(TemperatureType.fahrenheit.rawValue)"
            
        }
        
    }
    
    func getFeelsLikeTemperature(for info: CurrentWeather,with settings: Settings) -> String {
        
        switch settings.temperature {
        case .celsius:
            return "\(info.feelsLikeInCelsius)\(TemperatureType.celsius.rawValue)"
        case .fahrenheit:
            return "\(info.feelsLikeInFahrenheit)\(TemperatureType.fahrenheit.rawValue)"
            
        }
        
    }
    
    func getWindVelocity (for info:CurrentWeather,with settings: Settings) -> String {
        
        switch settings.velocity {
        case .mph:
            return "\(info.windInMilesPerHour)\(VelocityType.mph.rawValue)"
        case .kph:
            return "\(info.windInKilometerPerHour)\(VelocityType.kph.rawValue)"
        case .mps:
            return "\(info.windInKilometerPerHour / 3.6)\(VelocityType.mps.rawValue)"
        }
        
    }
    
    func getPressure(for info:CurrentWeather,with settings: Settings) -> String {
        switch settings.pressure {
            
        case .mmHg:
            return "\(info.pressureInMilliBars * mmHgCoefficient)\(PressureType.mmHg.rawValue)"
            
        case .mb:
            return "\(info.pressureInMilliBars)\(PressureType.mb.rawValue)"
            
        case .inches:
            return "\(info.pressureInInches)\(PressureType.inches.rawValue)"
            
        }
        
    }
    
    func getVisible(for info: CurrentWeather,with settings:Settings) -> String {
        
        switch settings.space {
        case .km:
            return "\(info.visibleInKiloMeters)\(SpaceType.km.rawValue)"
        case .mile:
            return "\(info.visibleInMiles)\(SpaceType.mile.rawValue)"
        }
        
    }
    
    func getGustVelocity(for info: CurrentWeather,with settings: Settings) -> String {
        
        switch settings.velocity {
            
        case .mph:
            return "\(info.gustInMilesPerHour)\(VelocityType.mph.rawValue)"
        case .kph:
            return "\(info.gustInKilometerPerHour)\(VelocityType.kph.rawValue)"
        case .mps:
            return "\(info.gustInKilometerPerHour / 3.6)\(VelocityType.kph.rawValue)"
        }
        
    }
    
}

