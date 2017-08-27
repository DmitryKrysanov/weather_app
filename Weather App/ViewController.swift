//
//  ViewController.swift
//  Weather App
//
//  Created by Dima on 08.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import UIKit
import Lottie

class ViewController: UIViewController, WeatherServiceDelegate {

    let weatherService = WeatherService()

    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
  
    
   
    @IBAction func setCityButton(_ sender: Any) {
       openCityAlert()
        
    }
 
    func openCityAlert() {
    
        let alertViewController = UIAlertController(title: "City", message: "Enter", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "OK", style: .default) { (action: UIAlertAction) in
            let textfield = alertViewController.textFields?[0]
            self.cityLabel.text = textfield?.text!
            let cityName = textfield?.text!
            self.weatherService.getWeather(city: cityName!)
        }
        
        alertViewController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertViewController.addAction(cancelAction)
        
        alertViewController.addTextField { (textField: UITextField) in
            textField.placeholder = "Enter City"
        }
        
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    
    func setWeather(weather: Weather) {
        cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.temp)"
        descriptionLabel.text = weather.description
        
        // тут будет вставляться анимация!
     
       
        let animationView = LOTAnimationView(name: weather.icon)
        self.view.addSubview(animationView)
        animationView.frame.origin.x = 160                  //x position
        animationView.frame.origin.y = 20                   //y position
        animationView.autoReverseAnimation = true
        animationView.loopAnimation = true
        animationView.play()
            // Do Something
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherService.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

