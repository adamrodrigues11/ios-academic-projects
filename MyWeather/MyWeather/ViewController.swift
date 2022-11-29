//
//  ViewController.swift
//  MyWeather
//
//  Created by Adam Rodrigues on 2022-11-26.
//

import UIKit
import CoreLocation

// table view
// custom cell: collection view
// API / request to get weather data



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    @IBOutlet var table: UITableView!
    
    var dailyViewModels = [DailyWeatherViewModel]()
    
    let locationManager = CLLocationManager()
    
    var currentLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register 2 cell types
        table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocation()
    }
    
    // Location
    
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
            
            // update view
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        }).resume()
    }
    
    // Table
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as! WeatherTableViewCell
        cell.configure(with: dailyViewModels[indexPath.row])
        return cell
    }
    
    
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




struct WeatherResponse : Codable {
    let latitude: Float
    let longitude: Float
    let generationtime_ms: Float
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Float
    let current_weather: CurrentWeather
    let hourly_units: HourlyUnits
    let hourly: HourlyWeather
    let daily_units: DailyUnits
    let daily: DailyWeather
    
}

struct CurrentWeather : Codable {
    let temperature: Float
    let windspeed: Float
    let winddirection: Float
    let weathercode: Int
    let time: String
}

struct HourlyUnits : Codable {
    let time: String
    let temperature_2m: String
    let apparent_temperature: String
    let precipitation: String
    let windspeed_10m: String
    let winddirection_10m: String
    let weathercode: String
}

struct HourlyWeather : Codable {
    let time: [String]
    let temperature_2m: [Float]
    let apparent_temperature: [Float]
    let precipitation: [Float]
    let windspeed_10m: [Float]
    let winddirection_10m: [Int]
    let weathercode: [Int]
}

struct DailyUnits : Codable {
    let time: String
    let temperature_2m_max: String
    let temperature_2m_min: String
    let precipitation_sum: String
    let weathercode: String
}

struct DailyWeather : Codable {
    let time: [String]
    let temperature_2m_max: [Float]
    let temperature_2m_min: [Float]
    let precipitation_sum: [Float]
    let weathercode: [Int]
}


