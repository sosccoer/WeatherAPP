//
//  RealTimeWeatherRespons.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import Foundation

struct RealTimeWeatherRespons: Codable {
    
    let currentWeather: CurrentWeather
    let currentLocation: WeatherLocation
    let forecastWeather: ForecastWeather
    
    enum CodingKeys: String, CodingKey {
        
        case currentWeather  = "current"
        case currentLocation = "location"
        case forecastWeather = "forecast"
    }
    
}
