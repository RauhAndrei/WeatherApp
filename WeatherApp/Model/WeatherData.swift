//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 27.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
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
    let id: Int
}
