//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 27.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

import Foundation
//MARK: - This struct is for changing of picture in display, based on conditionID form O.W.M
struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    
    var conditionName: String {
        switch conditionID {
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