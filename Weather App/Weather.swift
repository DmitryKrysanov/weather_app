//
//  Weather.swift
//  Weather App
//
//  Created by Dima on 12.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import Foundation

struct Weather {
    let cityName: String
    let temp: Int
    let description: String
    let icon: String
    let humidity: Int
    let windSpeed: Int
   
    var tempC: Int {
        get {
            return temp - 273
        }
    }
    init(cityName: String, temp: Int, description: String, humidity : Int, windSpeed: Int, icon: String) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
        self.humidity = humidity
        self.windSpeed = windSpeed
    }
}
