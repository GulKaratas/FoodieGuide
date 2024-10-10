//
//  ViewController.swift
//  FoodieGuide
//
//  Created by Gül Karataş on 9.10.2024.
//

import UIKit
import Lottie

class Home: UIViewController {

    let animationView = LottieAnimationView(name: "AnimationLottie")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupLottieAnimation()
    }
    
    @IBAction func signInClicked(_ sender: Any) {
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
    }
    
    func setupLottieAnimation() {
        
        animationView.frame = CGRect(x: 0, y: 100, width: 200, height: 200)
        animationView.center.x = self.view.center.x
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()

        
        view.addSubview(animationView)
    }
}

