//
//  CurrentWeather .swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 25.09.23.
//

import Foundation

struct CurrentWeather {
    let lastUpdated: UInt64
    let lastUpdateTimeFormatted: String
    let temperatureInCelsius: Double
    let temperatureInFahrenheit: Double
    let condition: WeatherCondiation
    let windInMilesPerHour: Double
    let windInKilometersPerHour: Double
    let windInDegrees: Int
    let windDirection: String
    let pressureInMilliBars: Double
    let pressureInInches: Double
    let precipitationInMilliMeters: Double
    let precipitationInInches: Double
    let humidity: Int
    let cloud: Int
    let feelsLikeInCelsius: Double
    let feelsLikeInFahrenheit: Double
    let visibleInKiloMeters: Double
    let visibleInMiles: Double
    let uvFactor: Double
    let gustInMilesPerHour: Double
    let gustInKilometerPerHour: Double
    
    private let isDayRaw: Int
    var isDay: Bool {
        get {
            Bool(isDayRaw)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case lastUpdateTimestamp        = "last_updated_epoch"
        case lastUpdateTimeFormatted    = "last_updated"
        case temperatureInCelsius       = "temp_c"
        case temperatureInFahrenheit    = "temp_f"
        case isDayRaw                   = "is_day"
        case condition                  = "condition"
        case windInMilesPerHour         = "wind_mph"
        case windInKilometerPerHour     = "wind_kph"
        case windInDegree               = "wind_degree"
        case windDirection              = "wind_dir"
        case pressureInMilliBars        = "pressure_mb"
        case pressureInInches           = "pressure_in"
        case precipitationInMilliMeters = "precip_mm"
        case precipitationInInches      = "precip_in"
        case humidity                   = "humidity"
        case cloud                      = "cloud"
        case feelsLikeInCelsius         = "feelslike_c"
        case feelsLikeInFahrenheit      = "feelslike_f"
        case visibleInKiloMeters        = "vis_km"
        case visibleInMiles             = "vis_miles"
        case uvFactor                   = "uv"
        case gustInMilesPerHour         = "gust_mph"
        case gustInKilometerPerHour     = "gust_kph"
    }
    
}

struct WeatherCondiation: Codable {
    
    let weatherText: String
    let photoOfWeather: String
    let codeOfWeather: Int
    
    enum CodingKeyss: String,CodingKey,Codable {
        
        case weatherText =    "text"
        case photoOfWeather = "icon"
        case codeOfWeather =  "code"
        
    }
    
    
}
