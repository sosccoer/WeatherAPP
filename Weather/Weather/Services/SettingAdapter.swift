//
//  SettingAdapter.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import Foundation

class SettingAdapter {
    
    private let mmHgCoefficient = 0.750063755419211
    
    func getTemperature(for info:CurrentWeather,with settings: Settings) -> String {
        
        switch settings.temperature {
        case .celsius:
            return "\(info.temperatureInCelsius) \(TemperatureType.celsius.rawValue)"
        case .fahrenheit:
            return "\(info.temperatureInFahrenheit) \(TemperatureType.fahrenheit.rawValue)"
            
        }
        
    }
    
    func getWindVelocity (for info:CurrentWeather,with settings: Settings) -> String {
        
        switch settings.velocity {
        case .mph:
            return "\(info.windInMilesPerHour) \(VelocityType.mph.rawValue)"
        case .kph:
            return "\(info.windInKilometerPerHour) \(VelocityType.kph.rawValue)"
        case .mps:
            return "\(info.windInKilometerPerHour / 3.6) \(VelocityType.mps.rawValue)"
        }
        
    }
    
    func getPressure(for info:CurrentWeather,with settings: Settings) -> String {
        switch settings.pressure {
            
        case .mmHg:
            return "\(info.pressureInMilliBars * mmHgCoefficient) \(PressureType.mmHg.rawValue)"
            
        case .mb:
            return "\(info.pressureInMilliBars) \(PressureType.mb.rawValue)"
            
        case .inches:
            return "\(info.pressureInInches) \(PressureType.inches.rawValue)"
            
        }
        
    }
    
}






