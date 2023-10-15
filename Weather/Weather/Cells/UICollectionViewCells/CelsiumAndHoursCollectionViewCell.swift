//
//  CelsiumAndHoursCollectionViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import UIKit

class CelsiumAndHoursCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var temperatureCelsium: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var image = UIImage()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.image = image
        
    }

}
