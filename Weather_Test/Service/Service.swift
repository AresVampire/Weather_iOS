//
//  Service.swift
//  Weather_Test
//
//  Created by Yugene on 5/22/19.
//  Copyright © 2019 Yugene. All rights reserved.
//

import Foundation
import AFNetworking

class Service {
    let appId: String = "9f83c91100de619bf5581359b6d44b55"
    
    private func getWeather(url: String, completion: @escaping (WeatherModel) -> (), onError: @escaping (NSError) -> ()) {
        let myUrl = NSURL(string: url)
        let request = NSMutableURLRequest(url: myUrl! as URL)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {
            data, response, error in
            if error != nil
            {
                onError(error! as NSError)
                return
            }
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:AnyObject]

                let maindic = dictionary?["main"] as! [String: AnyObject]
                let temp = (maindic["temp"] as! Double - 273.15)
                
                let weatherarr = dictionary?["weather"] as! NSArray
                let weatherdic = weatherarr[0] as! [String: AnyObject]
                let icon = weatherdic["icon"] as! String
                
                let wind = dictionary?["wind"] as! [String: AnyObject]
                let cloud = dictionary?["clouds"] as! [String: AnyObject]
                
                let name = dictionary?["name"] as! String
                
                completion(WeatherModel(name: name, icon: icon, temperature: temp, wind: wind, cloud: cloud))
                
            } catch let error as NSError {
                onError(error)
            }
        })
        task.resume()
    }
    
    func getWeatherWithLocation(lat: Double, long: Double, completion: @escaping (WeatherModel) -> (), onError: @escaping (NSError) -> ()) {
        let urlWithParams = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(appId)"
        getWeather(url: urlWithParams, completion: completion, onError: onError)
    }
    
    func getWeatherWithCity(city: String, completion: @escaping (WeatherModel) -> (), onError: @escaping (NSError) -> ()) {
        let urlWithParams = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(appId)"
        getWeather(url: urlWithParams, completion: completion, onError: onError)
    }
}
