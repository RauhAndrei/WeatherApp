//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 27.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

import Foundation
//MARK: - This file is implementation of data from OpenWeatherMap, it's for taking data from O.W.M.
struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

//MARK: - id is conditionID from O.W.M.
struct Weather: Decodable {
    let id: Int
}
