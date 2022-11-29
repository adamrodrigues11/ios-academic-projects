//
//  CurrentWeatherViewController.swift
//  MyWeather
//
//  Created by Adam Rodrigues on 2022-11-28.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController : UIViewController, CLLocationManagerDelegate {
    
    var dailyViewModels = [DailyWeatherViewModel]()
    var currentWeatherModel: CurrentWeather?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    @IBAction func dailyForecastButtonTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "showDailyWeather", sender: self)
    }
    
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var windDirectionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 52/255.0, green: 109/255.0, blue: 179/255.0, alpha: 1.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    // MARK - Get Location
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            requestWeatherForLocation()
        }
    }
    
    // MARK - Request Weather from API
    
    func requestWeatherForLocation() {
        guard let currentLocation = currentLocation else {
            return
        }
        let long = currentLocation.coordinate.longitude
        let lat = currentLocation.coordinate.latitude
        
        print("\(lat) | \(long)")
        
        let url = "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(long)&hourly=temperature_2m,apparent_temperature,precipitation,windspeed_10m,winddirection_10m,weathercode&models=best_match&daily=temperature_2m_max,temperature_2m_min,precipitation_sum,weathercode&current_weather=true&timezone=America%2FLos_Angeles"
        
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            // validation
            guard let data = data, error == nil else {
                print("Error requesting weather data")
                return
            }
            
            // convert data to models
            var json: WeatherResponse?
            do {
                json = try JSONDecoder().decode(WeatherResponse.self, from: data)
                
            }
            catch {
                print("Error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            self.dailyViewModels = self.createDailyWeatherViewModelsFromData(dailyWeatherdata: result.daily)
            
            self.currentWeatherModel = result.current_weather
            
            // update view
            DispatchQueue.main.async {
                self.generateView()
            }
            
        }).resume()
    }
    
    // MARK - Populate View Objects
    
    func generateView() {
        guard let currentWeather = currentWeatherModel else {
            return
        }
        tempLabel.text = "\(Int(currentWeather.temperature.rounded()))°"
        windSpeedLabel.text = "Wind Speed: \(Int(currentWeather.windspeed.rounded()))km/h"
        if let windDirection = WindDirectionLegend.getWindDirectionFromBearing(currentWeather.winddirection) {
            windDirectionLabel.text = "Wind Direction: \(windDirection)"
        }
        
        tempLabel.textAlignment = .center
        windSpeedLabel.textAlignment = .center
        windDirectionLabel.textAlignment = .center
        
        iconImageView.image = WeatherCodeLegend().getImageFromWeatherCode(currentWeather.weathercode)
    }
    
    
    // MARK - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DailyWeatherViewController
        if segue.identifier == "showDailyWeather" {
            destinationVC.dailyViewModels = dailyViewModels
        }
    }
    
    
    // MARK - Utils
    
    func createDailyWeatherViewModelsFromData(dailyWeatherdata:DailyWeather) -> [DailyWeatherViewModel] {
        var dailyViewModels = [DailyWeatherViewModel]()
        for index in 0...(dailyWeatherdata.time.count - 1) {
            dailyViewModels.append(DailyWeatherViewModel(
                time: dailyWeatherdata.time[index],
                temperature_2m_max: Int(dailyWeatherdata.temperature_2m_max[index].rounded()),
                temperature_2m_min: Int(dailyWeatherdata.temperature_2m_min[index].rounded()),
                precipitation_sum: Int(dailyWeatherdata.precipitation_sum[index].rounded()),
                weathercode: dailyWeatherdata.weathercode[index]
            ))
        }
        return dailyViewModels
    }
}

