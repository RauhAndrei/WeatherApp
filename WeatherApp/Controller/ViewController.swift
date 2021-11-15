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
    
    //MARK: - IBOutlets
    @IBOutlet weak var selectedCityLabel: UILabel!
    @IBOutlet weak var celciusNumberLabel: UILabel!
    @IBOutlet weak var outsideConditionImage: UIImageView!
    @IBOutlet weak var cityTextField: UITextField!
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization() ///Asking user to use their location
        locationManager.requestLocation() ///Request user location for using users current location
    }
    
    //MARK: - IBActions
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
            weatherManager.fetchWeather(cityName: city)
        }
        cityTextField.text = ""
    }
}

//MARK: - WeatherManagerDelegate

extension ViewController: WeatherManagerDelegate {
    
    func uploadWeatherToUI(_ weatherManager: WeatherManager,
                           weather: WeatherModel) {
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
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            ///stops the generation of location updates and use user location
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        print("Location manager didFailWithError --- \(error)")
    }
}
