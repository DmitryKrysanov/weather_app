//
//  WeatherService.swift
//  Weather App
//
//  Created by Dima on 12.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate {
    func setWeather(weather: Weather)
}

class WeatherService {
    var delegate: WeatherServiceDelegate?

    let openWeatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let openWeatherURLAPIKey = "bdf18d0e06a7caa20d03d92d59797e61"
    
    func getWeather(city: String){
        let urlString = URL(string: "\(openWeatherURL)?APPID=\(openWeatherURLAPIKey)&q=\(city)&units=metric")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let usableData = data {
                        
                        do {
                            let weatherJsonData = try JSONSerialization.jsonObject(with: usableData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                            
                            let lon = weatherJsonData["coord"]?["lon"] as! Double
                            let lat = weatherJsonData["coord"]?["lat"] as! Double
                            let temp = weatherJsonData["main"]?["temp"] as! Int
                            let name = weatherJsonData["name"] as! String
                            
                            
                            let weatherArray: NSArray = (weatherJsonData["weather"] as? NSArray)!
                            let weatherDictionary: NSDictionary = weatherArray[0] as! NSDictionary
                            
                           // let weatherMain = weatherDictionary["main"] as? String
                            let desc = weatherDictionary["description"] as? String
                            let icon = weatherDictionary["icon"] as? String
                            
                            let weather = Weather(cityName: name, temp: temp, description: desc!, icon: icon!)
                            
                            if self.delegate != nil {
                                DispatchQueue.global(qos: .userInitiated).async {
                                    DispatchQueue.main.async {
                                        self.delegate?.setWeather(weather: weather)
                                    }
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
    
 
}


