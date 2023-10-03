//
//  CityAndTemperatureCollectionViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 4.10.23.
//

import UIKit

class CityAndTemperatureCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var settingButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func presentSettingViewController(_ sender: Any) {
        
        let destination = SettingsViewController()
        
        
        
        
    }
    
}
