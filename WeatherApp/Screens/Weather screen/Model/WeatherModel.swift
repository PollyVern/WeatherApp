//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

struct WeatherModel {
    var country: String
    var province: String
    var week: [WeatherWeakModel]
}

struct WeatherWeakModel {
    var date: String
    var temp_avg: Int
    var feels_like: Int
    var wind_speed: Float
    var wind_gust: Float
}
