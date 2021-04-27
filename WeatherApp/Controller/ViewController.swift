//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 24.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    var weatherManager = WeatherManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTextField.delegate = self
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
            //MARK: - After that user typed the city name, this will be send to fetchWeather for understanding in what city will need to grab data
            weatherManager.fetchWeather(cityName: city)
        }
        
        cityTextField.text = ""
    }
    
}

