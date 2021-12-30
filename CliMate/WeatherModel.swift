//
//  WeatherModel.swift
//  CliMate
//
//  Created by Raunaq Vyas on 2021-12-27.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temprature: Double
    let description: String
    
    var tempratureString:String {
        let newtemp = String(format: "%.1f", temprature)
        return newtemp
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232 :
            return "cloud.bolt.rain"
        case 300...332:
            return "cloud.drizzle"
        case 500...532:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 711:
            return "smoke"
        case 741:
            return "cloud.fog"
        case 781:
            return "Tornado"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }

    var backgroundName: String {
        switch conditionId {
        case 200...232 :
            return "thunderstorm"
        case 300...332:
            return "drizzle"
        case 500...532:
            return "rain"
        case 600...622:
            return "snow"
        case 701...711:
            return "cloudy"
        case 741:
            return "fog"
        case 781:
            return "cloudBolt"
        case 800:
            return "clearSky"
        case 801...804:
            return "cloudy"
        default:
            return "cloudy"
        }
    }
    
}
