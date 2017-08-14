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
    
    init(cityName: String, temp: Int, description: String, icon: String) {
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
    }
}
