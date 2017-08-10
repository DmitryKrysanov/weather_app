//
//  GetWather.swift
//  Weather App
//
//  Created by Dima on 08.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import Foundation

class GetWaether {

    let openWeatherURL = "http://api.openweathermap.org/data/2.5/weather"
    let openWeatherURLAPIKey = "bdf18d0e06a7caa20d03d92d59797e61"
    
    func getWeather(city: String) {
    
        let urlString = URL(string: "\(openWeatherURL)?APPID=\(openWeatherURLAPIKey)&q=\(city)")
        if let url = urlString {
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            if error != nil {
            print(error!)
            } else {
                if let usableData = data {
                    print("Data is here: \(usableData)")
                    
                    do {
                        let weatherJsonData = try JSONSerialization.jsonObject(with: usableData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                        
                      //  print(weatherJsonData)
                      //  print("date and time: \(weatherJsonData["dt"]!)")
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
