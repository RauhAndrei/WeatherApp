//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 26.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

protocol WeatherManagerDelegate {
    func uploadWeatherToUI(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

import Foundation
import CoreLocation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=a7a00433fe426351d2479f04f93cd75f"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        let urlsString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlsString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlsString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlsString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.decodeJSON(safeData) {
                        self.delegate?.uploadWeatherToUI(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func decodeJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = (decodedData.weather[0].id)
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionID: id, cityName: name, temperature: temp)
            
            return weather
        } catch {
            delegate?.didFailWithError(error: error)
        }
        return nil
    }
}

