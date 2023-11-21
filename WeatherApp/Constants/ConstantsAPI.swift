//
//  ConstantsAPI.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

class ConstantsAPI {

    private static let sharedInstance = ConstantsAPI()

    public static func shared() -> ConstantsAPI {
        return sharedInstance
    }

    // MARK: Parameters
    let weatherKeyAPI = ProcessInfo.processInfo.environment["weather_key_API"] ?? ""
    let yandexApiHeader = "X-Yandex-API-Key"

    // MARK: URL strings
    let baseUrlString = "https://api.weather.yandex.ru/v2"
    let informersUrlString = "/forecast"

    // MARK: Request parameters
    let lat = "lat"
    let lon = "lon"
    let lang = "lang"
    let langRu = "ru_RU"
}
