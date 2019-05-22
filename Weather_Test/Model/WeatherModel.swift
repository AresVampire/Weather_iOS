//
//  WeatherModel.swift
//  Weather_Test
//
//  Created by Yugene on 5/22/19.
//  Copyright © 2019 Yugene. All rights reserved.
//

import Foundation

struct WeatherModel {
    var name: String
    var icon: String
    var temperature: Double
    var wind: [String: AnyObject]
    var cloud: [String: AnyObject]
}
