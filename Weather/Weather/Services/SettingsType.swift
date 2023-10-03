//
//  SettingsType.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import Foundation

enum VelocityType: String {
    case mph = "mph"
    case kph = "km/h"
    case mps = "m/s"
}

enum PressureType: String {
    case mmHg = "mmHg"
    case mb = "mb"
    case inches = "in"
}

enum PrecipitationType: String {
    case mm = "mm"
    case inches = "in"
}

enum TemperatureType: String {
    case celsius = "°C"
    case fahrenheit = "°F"
}

enum SpaceType: String {
    case km = "km"
    case mile = "mp"
}

class Settings {
    
    var velocity: VelocityType = .kph
    var pressure: PressureType = .mmHg
    var precipitation: PrecipitationType = .mm
    var temperature: TemperatureType = .celsius
    var space: SpaceType = .km
    
}
