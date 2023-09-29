//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 29.09.23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false 
        registerCell()
        
    }
    
    func registerCell () {
        
        let UINib = UINib(nibName: "CelsiumAndHoursCollectionViewCell", bundle: Bundle.main)
        collectionView.register(UINib, forCellWithReuseIdentifier: "CelsiumAndHoursCollectionViewCell")
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension WeatherTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CelsiumAndHoursCollectionViewCell", for: indexPath) as? CelsiumAndHoursCollectionViewCell else {return UICollectionViewCell()}
        
        return cell
    }
    
}

extension WeatherTableViewCell:UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Задайте размер ячейки для конкретного элемента в IndexPath
        return CGSize(width: 50, height: 110) // Пример размера ячейки
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // Задайте ваше кастомное расстояние между ячейками
    }
    
}
