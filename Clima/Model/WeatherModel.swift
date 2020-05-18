//
//  WeatherModel.swift
//  Clima
//
//  Created by Joseph Hannigan on 5/18/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel {
    // Stored Properties
    let conditionId: Int
    let cityName: String
    let temperature: Double
    
    // Computed Properties
    var conditionName: String {
        return getConditionName(weatherID: self.conditionId)
    }
    // Guarantees the temperature is return as a string to 1 decimal place
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    func getConditionName(weatherID: Int) -> String {
        switch weatherID {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}


