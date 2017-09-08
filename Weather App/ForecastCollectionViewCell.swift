//
//  ForecastCollectionViewCell.swift
//  Weather App
//
//  Created by Dima on 03.09.17.
//  Copyright © 2017 Dim. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var forecastImage: UIImageView!
    @IBOutlet weak var forecastTemp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
