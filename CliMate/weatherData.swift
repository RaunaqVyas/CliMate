//
//  weatherData.swift
//  CliMate
//
//  Created by Raunaq Vyas on 2021-12-27.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
