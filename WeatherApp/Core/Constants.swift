//
//  Constants.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

class Constants{
    static let baseUrl = "https://api.weather.yandex.ru/v2"
    static let weatherKeyAPI = ProcessInfo.processInfo.environment["weatherKeyAPI"] ?? ""
}
