//
//  ForecastWeather.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 9.10.23.
//

import Foundation

struct ForecastWeather: Codable {
    
    let forecastDay: [ForecastDay]
    
    enum CodingKeys: String,CodingKey {
        
        case forecastDay = "forecastday"
        
        
    }
    
}

struct ForecastDay: Codable {
    
    let date: String
    let day: Day
    let astrology: Astro
    let hour: [Hour]
    
    enum CodingKeys: String,CodingKey {
        
        case date =      "date"
        case day =       "day"
        case astrology = "astro"
        case hour =      "hour"
        
    }
    
    
}

struct Day: Codable {
    
    let maxTempCelsium: Double
    let maxTempFarenheit: Double
    
    let weatherCondition: WeatherCondiation
    
    enum CodingKeys: String ,CodingKey {
        
        case maxTempCelsium =   "maxtemp_c"
        case maxTempFarenheit = "maxtemp_f"
        case weatherCondition = "condition"
         
    }
    
}

struct Astro: Codable {
    
    let sunRise: String
    let sunSet: String
    
    enum CodingKeys: String,CodingKey {
        
        case sunRise = "sunrise"
        case sunSet  = "sunset"
        
    }
}

struct Hour : Codable {
    
    let time: String
    let temperatureInCelsium: Double
    let temperatureInFarenheit: Double
    let WeatherCondiation: WeatherCondiation
    
    enum CodingKeys: String, CodingKey {
        
        case time =                   "time"
        case temperatureInCelsium =   "temp_c"
        case temperatureInFarenheit = "temp_f"
        case WeatherCondiation =      "condition"
        
    }
}



