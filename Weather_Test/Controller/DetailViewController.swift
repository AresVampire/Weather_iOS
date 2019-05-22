//
//  DetailViewController.swift
//  Weather_Test
//
//  Created by Yugene on 5/22/19.
//  Copyright © 2019 Yugene. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelWind: UILabel!
    @IBOutlet weak var labelCloud: UILabel!
    
    var model: WeatherModel!
    
    override func viewDidLoad() {
        var wind: String = ""
        model.wind.keys.forEach { (key) in
            wind += "\(key): \(model.wind[key] is String ? model.wind[key] as! String : String(model.wind[key] as! Double))\n"
        }
        labelWind.text = wind
        
        var cloud: String = ""
        model.cloud.keys.forEach { (key) in
            cloud += "\(key): \(model.cloud[key] is String ? model.cloud[key] as! String : String(model.cloud[key] as! Double))\n"
        }
        labelCloud.text = cloud
    }
}
