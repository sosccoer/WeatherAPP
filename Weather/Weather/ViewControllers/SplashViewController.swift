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
    
}

