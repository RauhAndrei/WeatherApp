//
//  WeatherManager.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 26.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

import Foundation
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=a7a00433fe426351d2479f04f93cd75f"
    
    //MARK: - This function go to the url and send data to perfomRequest
    func fetchWeather(cityName: String) {
        let urlsString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlsString)
    }
    
    //MARK: - This function create url, session, task, and grab data from the url after send it to decode to decodeJSON
    func performRequest(urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.decodeJSON(weatherData: safeData)
                }
            }
            //4. Start the task
            task.resume()
            
        }
    }
    
    //MARK: - This function decode data from OpenWeatherMap and print it with WeatherData
    func decodeJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.main.temp)
        } catch {
            print(error)
        }
    }
    
}

