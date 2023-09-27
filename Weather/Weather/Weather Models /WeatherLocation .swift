//
//  WeatherLocation .swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 25.09.23.
//

import Foundation

struct WeatherLocation: Codable {
    
    let cityName: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
    let timeZone: String
    let localTimestamp: Int
    let localTime: String
    
    enum CodingKeys: String, CodingKey {
        
        case cityName       = "name"
        case region         = "region"
        case country        = "country"
        case latitude       = "lat"
        case longitude      = "lon"
        case timeZone       = "tz_id"
        case localTimestamp = "localtime_epoch"
        case localTime      = "localtime"
        
    }
    
}
