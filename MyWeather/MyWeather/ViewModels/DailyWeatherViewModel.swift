//
//  DailyWeatherViewModel.swift
//  MyWeather
//
//  Created by Adam Rodrigues on 2022-11-28.
//

import Foundation

class DailyWeatherViewModel {
    var _time: String
    var _temperature_2m_max: Int
    var _temperature_2m_min: Int
    var _precipitation_sum: Int
    var _weathercode: Int
    
    init(time:String, temperature_2m_max:Int, temperature_2m_min:Int, precipitation_sum:Int, weathercode:Int) {
        _time = time
        _temperature_2m_max = temperature_2m_max
        _temperature_2m_min = temperature_2m_min
        _precipitation_sum = precipitation_sum
        _weathercode = weathercode
    }
}
