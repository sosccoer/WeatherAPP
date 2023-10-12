//
//  WeatherAPIDelegate.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import Foundation

protocol WeatherAPIDelegate: AnyObject {
    
    func gotRealTimeWeather (respons: RealTimeWeatherRespons)
    func gotError(description: String)
    
}

enum WeatherRequestPath: String {
    
    case forecastWeather = "/forecast.json"
    
}

extension WeatherAPIDelegate {
    
    func gotError(description: String) {}
    
}
