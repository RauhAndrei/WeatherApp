//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 24.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBOutlet weak var selectedCityLabel: UILabel!
    @IBOutlet weak var celciusNumberLabel: UILabel!
    @IBOutlet weak var outsideConditionImage: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        cityTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cityTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = cityTextField.text {
            //MARK: - After user typed a city, this will be send to fetchWeather for understanding from what city will need to grab data
            weatherManager.fetchWeather(cityName: city)
        }
        
        cityTextField.text = ""
    }
    
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.celciusNumberLabel.text = weather.temperatureString
            self.outsideConditionImage.image = UIImage(systemName: weather.conditionName)
            self.selectedCityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}

