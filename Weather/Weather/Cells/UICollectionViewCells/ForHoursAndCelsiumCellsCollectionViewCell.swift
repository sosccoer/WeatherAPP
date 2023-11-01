//
//  ForHoursAndCelsiumCellsCollectionViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import UIKit
import RxSwift

class ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let mainViewController = MainViewController()
    
    private var viewModel: MainViewModel? = nil
    
    private let disposedBag = DisposeBag()
    
    var cells: [CelsiumAndHoursModel] = [
        
        CelsiumAndHoursModel(time: "12", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "12", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage()),
        CelsiumAndHoursModel(time: "", temperature: "", image: UIImage())
        
    ]{
        didSet {
            print(cells)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewModel = mainViewController.viewModel
        
        viewModel?.makeWeather()
        bindViewModelForHoursAndTemperature()
        setupCollectionView ()
        
    }
    
     func bindViewModelForHoursAndTemperature() {
        
         viewModel?.hoursAndTemperatureObservable.subscribe(onNext: { [weak self] cells in
            
            self?.cells = cells
            self?.collectionView.reloadData()
            
        }).disposed(by: disposedBag)
        
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
        cell.imageView.image = cells[index].image
        
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
