//
//  ForHoursAndCelsiumCellsCollectionViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import UIKit

class ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView ()
    }
    
    private func setupCollectionView () {
        
        collectionView.backgroundColor = UIColor.clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        registerCells ()
        
    }
    
    private func registerCells () {
        
        let nibOfCelsiumAndHours = UINib(nibName: "CelsiumAndHoursCollectionViewCell", bundle: Bundle.main)
        collectionView.register(nibOfCelsiumAndHours, forCellWithReuseIdentifier: "CelsiumAndHoursCollectionViewCell")
        
    }
    
}

extension ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        24
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CelsiumAndHoursCollectionViewCell", for: indexPath) as? CelsiumAndHoursCollectionViewCell else {return UICollectionViewCell()}
        return cell
    }
    
}

extension ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: 45, height: 110)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1 // Задайте ваше кастомное расстояние между ячейками
    }
    
}
