//
//  ForHoursAndCelsiumCellsCollectionViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import UIKit

class ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var cells: [CelsiumAndHoursModel] = [
        
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        CelsiumAndHoursModel(time: "", temperature: ""),
        
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView ()
    }
    
    private func setupCollectionView () {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        collectionView.collectionViewLayout = layout
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
        cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.row
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CelsiumAndHoursCollectionViewCell", for: indexPath) as? CelsiumAndHoursCollectionViewCell else {return UICollectionViewCell()}
        
        cell.temperatureCelsium.text = String(cells[index].temperature)
        cell.timeLabel.text = String(cells[index].time)
        
        return cell
    }
    
}

extension ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 45, height: 110)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
}
