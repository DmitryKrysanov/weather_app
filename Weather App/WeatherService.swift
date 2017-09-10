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
   
    //MARK: Get Weather for Location Function
    
    func getWeatherForLocation(_ location: CLLocation) {
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
   
        // Put together a URL With lat and lon
        let pathWeather = "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(openWeatherURLAPIKey)"
        getWeather(city: pathWeather)
        
        let pathForecast = "http://api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(openWeatherURLAPIKey)"
        getForecast(city: pathForecast)
    }

    //MARK: Get Weather Function
    
    func getWeather(city: String) {
        
        let urlString = URL(string: city)    //work with current location
        if urlString != nil {
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
                           // print(weather)
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

    //MARK: Get Forecast Function
    
    func getForecast(city: String) {
    
    let urlString = URL(string: city)      //work with current location
    if urlString != nil {
        let task = URLSession.shared.dataTask(with: urlString!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let usableData = data {
                    do {
                        let forecastJsonData = try JSONSerialization.jsonObject(with: usableData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                        
                        let forecastArray: NSArray = (forecastJsonData["list"] as? NSArray)!
                       
                        //-- need to use For!
                        
                        // get first values
                            let forecastFirstDictionary: NSDictionary = forecastArray[1] as! NSDictionary
                                let timeFirst = forecastFirstDictionary["dt_txt"] as?  String
                        
                            let forecastFirstMain: NSDictionary = (forecastFirstDictionary ["main"] as? NSDictionary)!
                                let tempFirst = forecastFirstMain["temp"] as! Int
                        
                            let forecastFirstWeatherArray: NSArray = (forecastFirstDictionary ["weather"] as? NSArray)!
                                let forecastFirstWeatherDictionary: NSDictionary = forecastFirstWeatherArray[0] as! NSDictionary
                                    let iconFirst = forecastFirstWeatherDictionary["icon"] as! String
                        
                        // get second values
                            let forecastSecondDictionary: NSDictionary = forecastArray[2] as! NSDictionary
                                let timeSecond = forecastSecondDictionary["dt_txt"] as?  String
                        
                            let forecastSecondMain: NSDictionary = (forecastSecondDictionary ["main"] as? NSDictionary)!
                                let tempSecond = forecastSecondMain["temp"] as! Int
                        
                            let forecastSecondWeatherArray: NSArray = (forecastSecondDictionary ["weather"] as? NSArray)!
                                let forecastSecondWeatherDictionary: NSDictionary = forecastSecondWeatherArray[0] as! NSDictionary
                                    let iconSecond = forecastSecondWeatherDictionary["icon"] as! String
                        
                         // get third values
                            let forecastThirdDictionary: NSDictionary = forecastArray[3] as! NSDictionary
                                let timeThird = forecastThirdDictionary["dt_txt"] as?  String
                        
                            let forecastThirdMain: NSDictionary = (forecastThirdDictionary ["main"] as? NSDictionary)!
                                let tempThird = forecastThirdMain["temp"] as! Int
                        
                            let forecastThirdWeatherArray: NSArray = (forecastThirdDictionary ["weather"] as? NSArray)!
                                let forecastThirdWeatherDictionary: NSDictionary = forecastThirdWeatherArray[0] as! NSDictionary
                                    let iconThird = forecastThirdWeatherDictionary["icon"] as! String
                        
                        //--
                        
                            let forecast = Forecast(timeFirst: timeFirst!, tempFirst: tempFirst, iconFirst: iconFirst, timeSecond: timeSecond!, tempSecond: tempSecond, iconSecond: iconSecond, timeThird: timeThird!, tempThird: tempThird, iconThird: iconThird)
                        
                       //print(forecast)
               
                        if self.delegate != nil {
                           
                                DispatchQueue.main.async {
                                    self.delegate?.setForecast(forecast: forecast)
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



