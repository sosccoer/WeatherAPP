//
//  MainTableViewModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import Foundation
import UIKit

struct MainCollectionViewModel {
    
    let type: TypeOfMainCollectionView
//    let nameOfSetting: String?
//    let value: String?
//    let imageAboutWeather: UIImage?
    
    enum TypeOfMainCollectionView {
        
        case ForSquareTableViewCollectionViewCell
        case CelsiumAndHoursCollectionViewCell
        case CityAndTemperatureCollectionViewCell
        
    }
    
    
}
