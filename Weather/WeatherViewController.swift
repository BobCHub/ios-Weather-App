//
//  ViewController.swift
//  Converter
//
//  Created by Robert Cook on 2019-03-12.
//  Copyright © 2019 Robert Cook. All rights reserved.
//

import UIKit
import CoreLocation   // Core Location provides services for determining a device's geographic location
                      // Use CocoaPods dependency manager for updates commandline_> pod update
import Alamofire      // Alamofire is an HTTP networking library written in Swift
import SwiftyJSON     // SwiftyJSON makes it easy to deal with JSON data in Swift


class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "2273bb68fa9d2d5c80ce56c89ae707fb"
    
    // Declare instance variables
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    // IBOutlets - Temp Result, City, Icon
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    // viewDidLoad
    /***************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the location manager
        // new - let locationManager = CLLocationManager()
        locationManager.delegate = self
        // new - let weatherDataModel = WeatherDataModel()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // Get user permission - go to decription in info.plist
        locationManager.requestWhenInUseAuthorization()
        // Async method to update location - CoreLocation
        locationManager.startUpdatingLocation()
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    // getWeatherData method here:
    func getWeatherData(url: String, parameters: [String: String]) {
        
        // Use Alamofire Async HTTP get request to aquire json weather data from openweathermap API
        // Alamofire method Doc - https://github.com/Alamofire/Alamofire/blob/master/Documentation/Usage.md#http-methods
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            // check for success
            if response.result.isSuccess {
                // test
                print("Success! Got the weather data")
                // create JSON object from request response using SwiftyJson
                // SwiftyJson method Doc https://github.com/SwiftyJSON/SwiftyJSON#usage
                let weatherJSON : JSON = JSON(response.result.value!)
                    // test
                    print(weatherJSON)
                // Pass in data from data server -> json
                self.updateWeatherData(json: weatherJSON)
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }

    //MARK: - JSON Parsing
    /***************************************************************/
   
    // updateWeatherData method: Set openweathermap variables
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {                           // temperature Unit Default: Kelvin
        // weatherDataModel.humidity = json["main"]["humidity"].doubleValue             // humidity
        
        weatherDataModel.temperature = Int(tempResult - 273.15)                      // convert kelvin to celsius
        weatherDataModel.city = json["name"].stringValue                             // city name
        weatherDataModel.condition = json["weather"][0]["id"].intValue               // weather id
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition) // Icon

        updateUIWithWeatherData()
        }
        else {
               cityLabel.text = "Weather Unavailable"
           }
        }

    //MARK: - UI Updates
    /***************************************************************/
    
    // update UI Components method:
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        temperatureLabel.text = "\(weatherDataModel.temperature)°"
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }

    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    // didUpdateLocations method:
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            // grab last location
            let location = locations[locations.count - 1]
            // check location is valid
            if location.horizontalAccuracy > 0 {
                // see data once
                locationManager.stopUpdatingLocation()
                locationManager.delegate = nil
                // test Simulator custom Location coordinates - Victoria BC
                print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
                
                let latitude = String(location.coordinate.latitude)
                let longitude = String(location.coordinate.longitude)
                // create dictionary - lat long parameters from openweathermapp using API key
                let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
                
                getWeatherData(url: WEATHER_URL, parameters: params)
            }
        }
    
    // didFailWithError method: Air plane mode, no internet access
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
            cityLabel.text = "Location Unavailable"
        }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    // userEnteredANewCityName Delegate method:
    func userEnteredANewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }

    // PrepareForSegue Method:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // use segue to ChangeCityViewController
        if segue.identifier == "changeCityName" {
            // create destinationVC object -> set destination
            let destinationVC = segue.destination as! ChangeCityViewController

            destinationVC.delegate = self
            
        }
    }
}


