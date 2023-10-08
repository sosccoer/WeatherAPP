//
//  ForecastWeather.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 9.10.23.
//

import Foundation

struct ForecastDaytWeather: Codable {
    
    let zero: zero
    let first: zero
    let secont: zero
    
    enum CodingKeys: String,CodingKey {
        
        case zero =   "0"
        case first =  "1"
        case secont = "2"
        
    }
    
}

struct zero: Codable {
    
    let date: String
    let astro: Astro
    
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
        
        case time = "time"
        case temperatureInCelsium = "temp_c"
        case temperatureInFarenheit = "temp_f"
        case WeatherCondiation = "condition"
        
    }
}



struct Hours: Codable {
    
    let zero: Hour
    let one: Hour
    let two: Hour
    let three: Hour
    let four: Hour
    let five: Hour
    let six: Hour
    let seven: Hour
    let eight: Hour
    let nine: Hour
    let ten: Hour
    let eleven: Hour
    let twelve: Hour
    let threteen: Hour
    let fourteen: Hour
    let fiveteen: Hour
    let sixteen: Hour
    let seventyteen: Hour
    let eighteen: Hour
    let nineteen: Hour
    let twenty: Hour
    let twentyOne: Hour
    let twentyTwo: Hour
    let twentyFree: Hour
    
    enum CodingKeys: String,CodingKey {
        
        case zero =        "0"
        case one =         "1"
        case two =         "2"
        case three =       "3"
        case four =        "4"
        case five =        "5"
        case six =         "6"
        case seven =       "7"
        case eight =       "8"
        case nine =        "9"
        case ten =         "10"
        case eleven =      "11"
        case twelve =      "12"
        case threteen =    "13"
        case fourteen =    "14"
        case fiveteen =    "15"
        case sixteen =     "16"
        case seventyteen = "17"
        case eighteen =    "18"
        case nineteen =    "19"
        case twenty =      "20"
        case twentyOne =   "21"
        case twentyTwo =   "22"
        case twentyFree =  "23"
        
    }
    
    
}
