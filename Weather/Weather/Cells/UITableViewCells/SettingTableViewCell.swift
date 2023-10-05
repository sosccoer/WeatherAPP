//
//  SettingTableViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 3.10.23.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var segmentedControlAction: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @objc func segmentedControlValueChanged() {
            // Вызывается при изменении значения UISegmentedControl
            let selectedIndex = segmentControl.selectedSegmentIndex
            segmentedControlAction?(selectedIndex)
        }
    
    
        
      
        
    
    
}
