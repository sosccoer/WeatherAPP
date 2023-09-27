//
//  MainViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import UIKit

class MainViewController: UIViewController {
    
    private let apiWeather = ApiWeather()
    
    var lastRespons: RealTimeWeatherRespons?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiWeather.delegate = self
        
    }
    
}

extension MainViewController: WeatherAPIDelegate {
    
    func gotRealTimeWeather(respons: RealTimeWeatherRespons) {
        
        lastRespons = respons
    }
    
    func gotError(description: String) {
        
        let alert = UIAlertController(title: "Error", message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
    }
    
}


