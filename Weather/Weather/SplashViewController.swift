//
//  ViewController.swift
//  Weather
//
//  Created by lelya.rumynin@gmail.com on 25.09.23.
//

import UIKit
import Alamofire
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lottieAnimation: LottieAnimationView!
    
    private var animation: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAnimation()
        
        makeCurrentWeather()
        
    }
    
    private func setupAnimation () {
        lottieAnimation.backgroundColor = UIColor(red: 0x38/255.0, green: 0x99/255.0, blue: 0xE0/255.0, alpha: 1.0)
        animation = .init(name: "Weather" )
        animation.loopMode = .playOnce
        animation.contentMode = .scaleAspectFit
        animation.frame = lottieAnimation.bounds
        animation.animationSpeed = 1
        lottieAnimation.addSubview(animation)
        animation.play(){ [weak self] (finished) in
            
            if finished {
                
                let mainViewController = MainViewController()
                mainViewController.modalPresentationStyle = .fullScreen
                
                self?.present(mainViewController,animated: true)
                
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    private let baseURL = "weatherapi- com.p.rapidapi.com"
    private let APIKey = "7ce6d3fdd1msh9f459f298adcf7dp102dc3jsn4f05a45ca743"
    
    func makeCurrentWeather () {
        
        let URLComponents = makeURLComponents(for: .currentWeather, place: "Minsk")
        let headers: HTTPHeaders = HTTPHeaders([
            "X-RapidAPI-Key" : self.APIKey,
            "X-RapidAPI-Host" : self.baseURL
        ])
        
        AF.request(URLComponents,headers: headers).response { response in
            
            guard response.error == nil else {
                print("WeatherApiWorker: Request error")
                return
            }
            
            guard let data = response.data else {
                print("WeatherApiWorker: Response error")
                return
            }
            
            guard (200..<300).contains(response.response?.statusCode ?? 0) else {
                print("WeatherApiWorker: Wrong Status code")
                return
            }
            
            guard let responseString = String(data: data, encoding: .utf8) else {
                print("WeatherApiWorker: Worng response encoding")
                return
            }
            
            print("WeatherApiWorker: \(responseString)")
            
            guard let responseModel = try? JSONDecoder().decode(RealTimeWeatherRespons.self, from: data) else {
                print("WeatherApiWorker: Decode error")
                return
            }
            
            print("WeatherApiWorker: \(responseModel)")
            
        }
        
    }
    
    private func makeURLComponents(for weatherType: WeatherRequestPath, place: String) -> URLComponents {
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = self.baseURL
        components.path = weatherType.rawValue
        components.queryItems = [URLQueryItem(name: "q", value: place)]
        
        return components
        
    }
    
    enum WeatherRequestPath: String {
        case currentWeather = "/current.json"
    }
    
}
