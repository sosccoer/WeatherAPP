//
//  SettingViewControllerModel.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import Foundation

struct TypeOfTableViewCell {
    
    let type: SettingTypeOfCell
    let nameOfSetting: String
    let nameOfValues: [String]
    
    enum SettingTypeOfCell {
        
        case SettingTableViewCell
        
    }
    
}


