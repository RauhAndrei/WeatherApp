//
//  ViewController.swift
//  WeatherApp
//
//  Created by Rauh Andrei on 24.04.2021.
//  Copyright © 2021 Rauh Andrei. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var selectedCityLabel: UILabel!
    @IBOutlet weak var celciusNumberLabel: UILabel!
    @IBOutlet weak var outsideConditionImage: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        //MARK: - Asking user to use their location (also in info.plist add a new property)
        locationManager.requestWhenInUseAuthorization()
        //MARK: - Request one time user location for using users current location
        locationManager.requestLocation()
    }
    
    @IBAction func currentLocationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    
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
            //MARK: - After user typed a city, this will be send to fetchWeather for grab data from the city
            weatherManager.fetchWeather(cityName: city)
        }
        cityTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func uploadWeatherToUI(_ weatherManager: WeatherManager, weather: WeatherModel) {
        //MARK: - This is used for run the task on the main thread.(This kind of tasks in background may cause problems)
        DispatchQueue.main.async {
            self.celciusNumberLabel.text = weather.temperatureString
            self.outsideConditionImage.image = UIImage(systemName: weather.conditionName)
            self.selectedCityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print("WeatherManagerDelegate - didFailWithError --- \(error)")
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            //MARK: - This method stops the generation of location updates and use only first user location
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager didFailWithError --- \(error)")
    }
}
