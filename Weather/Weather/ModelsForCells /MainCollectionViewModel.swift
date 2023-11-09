//
//  MainTableViewModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import Foundation
import UIKit

struct MainCollectionViewModel:Codable {
    
    let type: TypeOfMainCollectionView
    let nameOfSetting: String?
    let value: String?
    
    enum TypeOfMainCollectionView: Codable {
        
        case ForSquareTableViewCollectionViewCell
        case CelsiumAndHoursCollectionViewCell
        case CityAndTemperatureCollectionViewCell
        
    }
    
    
}
