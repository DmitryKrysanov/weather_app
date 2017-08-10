//
//  ViewController.swift
//  Weather App
//
//  Created by Dima on 08.08.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var weather = GetWaether()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        weather.getWeather(city: "Kharkiv,UA")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

