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
    
    // MARK: Outlets
    
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
  
    @IBOutlet weak var forecastTimeFirst: UILabel!
    @IBOutlet weak var forecastTempFirst: UILabel!
    @IBOutlet weak var firstCell: ForecastViewCell!
    @IBOutlet weak var forecastIconFirst: UIImageView!
    
    @IBOutlet weak var forecastTimeSecond: UILabel!
    @IBOutlet weak var forecastTempSecond: UILabel!
    @IBOutlet weak var forecastIconSecond: UIImageView!
    
    @IBOutlet weak var forecastTimeThird: UILabel!
    @IBOutlet weak var forecastTempThird: UILabel!
    @IBOutlet weak var forecastIconThird: UIImageView!
    
// MARK: Set Current Weather Function
    
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
    }
    
  // MARK: Set Forecast Function
    
    func setForecast(forecast: Forecast) {
    let timeFirst = forecast.timeFirst
    let shortTimeFirst = timeFirst.index(timeFirst.startIndex, offsetBy: 11)..<timeFirst.index(timeFirst.endIndex, offsetBy: -3)
    let shortTimeFirstResult = timeFirst[shortTimeFirst]
    forecastTimeFirst.text = shortTimeFirstResult
    forecastTempFirst.text = "\(forecast.tempFirstC)"
    forecastIconFirst.image = UIImage(named: "\(forecast.iconFirst)")

    let timeSecond = forecast.timeSecond
    let shortTimeSecond = timeSecond.index(timeSecond.startIndex, offsetBy: 11)..<timeSecond.index(timeSecond.endIndex, offsetBy: -3)
    let shortTimeSecondResult = timeSecond[shortTimeSecond]
    forecastTimeSecond.text = shortTimeSecondResult
    forecastTempSecond.text = "\(forecast.tempSecondC)"
    forecastIconSecond.image = UIImage(named: "\(forecast.iconSecond)")

    let timeThird = forecast.timeThird
    let shortTimeThird = timeThird.index(timeThird.startIndex, offsetBy: 11)..<timeThird.index(timeThird.endIndex, offsetBy: -3)
    let shortTimeThirdResult = timeThird[shortTimeThird]
    forecastTimeThird.text = shortTimeThirdResult
    forecastTempThird.text = "\(forecast.tempThirdC)"
    forecastIconThird.image = UIImage(named: "\(forecast.iconThird)")
        
    }
    
    // MARK: Get Location Function
    
    func getGPSLocation() {
        locationManager.startUpdatingLocation()
    }
    
     // MARK: Location Manager Function

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

