//
//  Forecast.swift
//  Weather App
//
//  Created by Dima on 03.09.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import Foundation

struct Forecast {
    let timeFirst: String
    let tempFirst: Int
    let iconFirst: String
    
    let timeSecond: String
    let tempSecond: Int
    let iconSecond: String
    
    let timeThird: String
    let tempThird: Int
    let iconThird: String

  
    //-- need to use function!
    
    var tempFirstC: Int {
        get {
            return tempFirst - 273
        }
    }
    
    var tempSecondC: Int {
        get {
            return tempSecond - 273
        }
    }
    
    var tempThirdC: Int {
        get {
            return tempThird - 273
        }
    }
    
    //--

    init(timeFirst: String, tempFirst: Int, iconFirst: String, timeSecond: String, tempSecond: Int, iconSecond: String, timeThird: String, tempThird: Int, iconThird: String) {
        self.timeFirst = timeFirst
        self.tempFirst = tempFirst
        self.iconFirst = iconFirst
        
        self.timeSecond = timeSecond
        self.tempSecond = tempSecond
        self.iconSecond = iconSecond
        
        self.timeThird = timeThird
        self.tempThird = tempThird
        self.iconThird = iconThird
    }
}
