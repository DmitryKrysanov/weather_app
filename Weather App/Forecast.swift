//
//  Forecast.swift
//  Weather App
//
//  Created by Dima on 03.09.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import Foundation

struct Forecast {
    let time: String
//    let cityName: String
//    let temp: Int
//    let icon: String
//    let humidity: Int
//    
//    var tempC: Int {
//        get {
//            return temp - 273
//        }
//    }
//    init(cityName: String, temp: Int, humidity : Int, icon: String) {
//        self.cityName = cityName
//        self.temp = temp
//        self.icon = icon
//        self.humidity = humidity
//    }
//}

    init(time: String) {
        self.time = time
    }
}
