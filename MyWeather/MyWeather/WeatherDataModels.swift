//
//  WeatherDataModels.swift
//  MyWeather
//
//  Created by Adam Rodrigues on 2022-11-28.
//

import Foundation


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
