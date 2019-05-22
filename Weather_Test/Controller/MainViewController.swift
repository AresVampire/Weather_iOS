//
//  ViewController.swift
//  Weather_Test
//
//  Created by Yugene on 5/22/19.
//  Copyright © 2019 Yugene. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var userLocation: CLLocation?
    var locationManager = CLLocationManager()
    
    var data: [WeatherModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        for _ in 0..<3 {
            data.append(WeatherModel(name: "", icon: "", temperature: 0, wind: [:], cloud: [:]))
        }
        
        Service().getWeatherWithCity(
            city: "London",
            completion: { (weather) in
                self.data[1] = weather
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }) { (error) in
            
        }
        
        Service().getWeatherWithCity(
            city: "Tokyo",
            completion: { (weather) in
                self.data[2] = weather
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }) { (error) in
            
        }
    }

    //
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell        
        
        if !(data[indexPath.row].icon.isEmpty) {
            cell.labelLocation.text = data[indexPath.row].name
            cell.labelTemperature.text = String(format: "%.3f°C", data[indexPath.row].temperature)
            cell.imageWeather.kf.setImage(with: URL(string: "http://openweathermap.org/img/w/\(data[indexPath.row].icon).png"))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !(data[indexPath.row].icon.isEmpty) {
            let controller = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            controller.model = data[indexPath.row]
            navigationController?.pushViewController(controller, animated: true)
        }
    }

    //
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        userLocation = locations[0]
        
        locationManager.stopUpdatingLocation()
        
        Service().getWeatherWithLocation(
            lat: (userLocation?.coordinate.latitude)!,
            long: (userLocation?.coordinate.longitude)!,
            completion: { (weather) in
                self.data[0] = weather
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }) { (error) in
            
            }
    }
}

