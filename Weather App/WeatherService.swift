//
//  WeatherService.swift
//  Weather App
//
//  Created by Dima on 12.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
    func setForecast(forecast: Forecast)
}

class WeatherService {
    var delegate: WeatherServiceDelegate?
    
    let openWeatherURLAPIKey = "bdf18d0e06a7caa20d03d92d59797e61"
   
    func getWeatherForLocation(_ location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
   
        // Put together a URL With lat and lon
        let pathWeather = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(openWeatherURLAPIKey)"
        getWeather(city: pathWeather)
        
        let pathForecast = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(openWeatherURLAPIKey)"
        getForecast(city: pathForecast)
    }
    

    
    //написать 2 функции. Певая: по текущей позиции, вторая - по введеному городу.
  //  Первая должна вызываться сразу, вторая после нажатия ОК
    
    
    
    func getWeather(city: String) {
        
        let urlString = URL(string: city)    //work with current location
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let usableData = data {
                        do {
                            let weatherJsonData = try JSONSerialization.jsonObject(with: usableData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                            let temp = weatherJsonData["main"]?["temp"] as! Int
                            let name = weatherJsonData["name"] as! String
                            let humidity = weatherJsonData["main"]?["humidity"] as! Int
                            let windSpeed = weatherJsonData["wind"]?["speed"] as! Int
                           
                            let weatherArray: NSArray = (weatherJsonData["weather"] as? NSArray)!
                            let weatherDictionary: NSDictionary = weatherArray[0] as! NSDictionary
                           
                            let desc = weatherDictionary["description"] as? String
                            let icon = weatherDictionary["icon"] as? String
                            let weather = Weather(cityName: name, temp: temp, description: desc!, humidity: humidity, windSpeed: windSpeed, icon: icon!)
                            
                            if self.delegate != nil {
                                        DispatchQueue.main.async {
                                        self.delegate?.setWeather(weather: weather)
                                    }
            
                            }
                            print(weather)
                        }
                        catch let jsonError as NSError {
                            print("JSON error: \(jsonError.description)")
                        }
                    }
                }
            }
            task.resume()
        }
    }

func getForecast(city: String) {
    
    let urlString = URL(string: city)      //work with current location
    if let url = urlString {
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    do {
                        let forecastJsonData = try JSONSerialization.jsonObject(with: usableData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                        
                        let forecastArray: NSArray = (forecastJsonData["list"] as? NSArray)!
                        let forecastDictionary: NSDictionary = forecastArray[0] as! NSDictionary
                        
                         let time = forecastDictionary["dt_txt"] as?  String
                        print(time)
                        let forecast = Forecast(time: time!)
                  
                        
                        if self.delegate != nil {
                            DispatchQueue.global(qos: .userInitiated).async {
                                DispatchQueue.main.async {
                                    self.delegate?.setForecast(forecast: forecast)
                                }
                            }
                        }
                      
                    }
                    catch let jsonError as NSError {
                        print("JSON error: \(jsonError.description)")
                    }
                }
            }
        }
        task.resume()
    }
}
}



