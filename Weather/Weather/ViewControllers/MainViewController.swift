//
//  MainViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 27.09.23.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    private let apiWeather = ApiWeather()
    
    var lastRespons: RealTimeWeatherRespons?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        apiWeather.delegate = self
        
        setupTableView()
        
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        registerTableViewCells()
        
    }
    
    func registerTableViewCells () {
        
        let nibName = UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main)
        tableView.register(nibName, forCellReuseIdentifier: "WeatherTableViewCell")
        
    }
      
}

extension MainViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as? WeatherTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 120.0 // Высота для первой ячейки
        } else if indexPath.row == 1 {
            return 120.0 // Высота для второй ячейки
        } else {
            return 60.0 // Высота для остальных ячеек
        }
        
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






