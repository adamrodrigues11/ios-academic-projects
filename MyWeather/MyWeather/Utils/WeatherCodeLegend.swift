//
//  WeatherCodeLegend.swift
//  MyWeather
//
//  Created by Adam Rodrigues on 2022-11-28.
//

import Foundation
import UIKit

class WeatherCodeLegend {
    
    let legend = [
        0 : "sun.max.fill",
        1 : "cloud.sun",
        2 : "cloud.sun",
        3: "cloud",
        45: "cloud",
        48: "cloud",
        51: "cloud.rain",
        53: "cloud.rain",
        55: "cloud.rain",
        56: "cloud.rain",
        57: "cloud.rain",
        61: "cloud.rain",
        63: "cloud.rain",
        65: "cloud.rain",
        66: "cloud.rain",
        67: "cloud.rain",
        80: "cloud.rain",
        81: "cloud.rain",
        82: "cloud.rain",
        71: "cloud.snow",
        73: "cloud.snow",
        75: "cloud.snow",
        77: "cloud.snow",
        85: "cloud.snow",
        86: "cloud.snow",
        95: "cloud.bolt.rain",
        96: "cloud.bolt.rain",
        99: "cloud.bolt.rain"
    ]
    
    func getImageFromWeatherCode(_ weatherCode: Int) -> UIImage? {
        guard let imageName = self.legend[weatherCode] else {
            return nil
        }
        return UIImage(named: imageName)
    }
}
