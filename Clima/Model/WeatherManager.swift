//
//  WeatherManager.swift
//  Clima
//
//  Created by Joseph Hannigan on 5/17/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = ""
    let units = "imperial"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)?q=\(cityName)&units=\(units)&appid=\(apiKey)"
        self.performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URL session
            let session = URLSession(configuration: .default)
            //3. Give the session a task and use a closure to simplify the code
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                    
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            print(weather.conditionName)
        } catch {
            print(error)
        }
    }
    
    
}
