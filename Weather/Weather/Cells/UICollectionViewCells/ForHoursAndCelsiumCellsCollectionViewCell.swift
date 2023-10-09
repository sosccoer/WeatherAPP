//
//  ForHoursAndCelsiumCellsCollectionViewCell.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 30.09.23.
//

import UIKit

class ForHoursAndCelsiumCellsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var lastRespons: RealTimeWeatherRespons?
    
    var cells: [CelsiumAndHoursModel] = [
    
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    CelsiumAndHoursModel(time: "", temperature: 0),
    
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView ()
        
         let destination = MainViewController()
            
        destination.collbackForUpdateHoursAndTemperatureCell = {
            self.updateCells()

        }
                    
    }
    
    private func updateCells() {
        
        guard let forecast = lastRespons?.forecastWeather.forecastDay else {return}
        
        self.cells = [
        
            CelsiumAndHoursModel(time: forecast[0].hour[0].time, temperature: forecast[0].hour[0].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[1].time, temperature: forecast[0].hour[1].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[2].time, temperature: forecast[0].hour[2].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[3].time, temperature: forecast[0].hour[3].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[4].time, temperature: forecast[0].hour[4].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[5].time, temperature: forecast[0].hour[5].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[6].time, temperature: forecast[0].hour[6].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[7].time, temperature: forecast[0].hour[7].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[8].time, temperature: forecast[0].hour[8].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[9].time, temperature: forecast[0].hour[9].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[10].time, temperature: forecast[0].hour[10].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[11].time, temperature: forecast[0].hour[11].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[12].time, temperature: forecast[0].hour[12].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[13].time, temperature: forecast[0].hour[13].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[14].time, temperature: forecast[0].hour[14].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[15].time, temperature: forecast[0].hour[15].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[16].time, temperature: forecast[0].hour[16].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[17].time, temperature: forecast[0].hour[17].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[18].time, temperature: forecast[0].hour[18].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[19].time, temperature: forecast[0].hour[19].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[20].time, temperature: forecast[0].hour[20].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[21].time, temperature: forecast[0].hour[21].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[22].time, temperature: forecast[0].hour[22].temperatureInCelsium),
            CelsiumAndHoursModel(time: forecast[0].hour[23].time, temperature: forecast[0].hour[23].temperatureInCelsium)
        
        ]
        
        collectionView.reloadData()
        
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
        
//        print("вот такое время: \(String(cells[index].time)) и вот такая температура: \(String(cells[index].temperature))")
        
        collectionView.reloadData()
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
