//
//  ViewController.swift
//  Weather App
//
//  Created by Dima on 08.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import UIKit
import CoreLocation
import Lottie

class MainPageViewController: UIViewController, WeatherServiceDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var animView: UIView!

    @IBOutlet weak var animationView: UIView!
    let weatherService = WeatherService()
    let locationManager = CLLocationManager()
    

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var TextField: UITextField!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
  
    @IBAction func setCity(_ sender: Any) {
        let textfield = TextField
        self.cityLabel.text = textfield?.text!
        let cityName = textfield?.text!
        self.weatherService.getWeather(city: cityName!)
        
        
        
        
    }
    
   
    @IBAction func setCityButton(_ sender: Any) {
      // openCityAlert()
        
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
        cityLabel.text = cityLabel.text?.uppercased()
        tempLabel.text = "\(weather.tempC)"
        descriptionLabel.text = weather.description
        descriptionLabel.text = descriptionLabel.text?.uppercased()
        humidityLabel.text = "\(weather.humidity)"
        windSpeedLabel.text = "\(weather.windSpeed)"

        let startAnimation = LOTAnimationView(name: weather.icon)
        
        startAnimation.frame = CGRect(x: 0, y: 0, width: startAnimation.frame.size.width, height: startAnimation.frame.size.height)
        startAnimation.loopAnimation = true
        
        animView.frame = CGRect(x: animView.frame.origin.x, y: animView.frame.origin.y, width: startAnimation.frame.size.width, height: startAnimation.frame.size.height)
       
        animView.addSubview(startAnimation)
        
        startAnimation.play()
          //   Do Something
    }
    
    func setForecast(forecast: Forecast){
    //code
    }
    
    
    
    
    func getGPSLocation() {
        locationManager.startUpdatingLocation()
    }
    

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.weatherService.getWeatherForLocation(locations[0])
        locationManager.stopUpdatingLocation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        self.weatherService.delegate = self
        self.getGPSLocation()
    }
  }

