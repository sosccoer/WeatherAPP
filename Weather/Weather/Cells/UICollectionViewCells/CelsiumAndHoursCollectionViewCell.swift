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
    
    var url: String? {
        didSet {
            
            guard let URL = URL(string: url ?? "") else {return}
                    
            if let data = try? Data(contentsOf: URL) {
                
                let image = UIImage(data: data)
                imageView.image = image
                
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
    }

}
