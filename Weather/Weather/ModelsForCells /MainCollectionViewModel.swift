//
//  MainTableViewModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import Foundation

struct MainCollectionViewModel {
    
    let type: TypeOfMainCollectionView
    
    enum TypeOfMainCollectionView {
        
        case ForSquareTableViewCollectionViewCell
        case CelsiumAndHoursCollectionViewCell
        case ImageAboutWeatherCollectionViewCell
    }
    
    
}
