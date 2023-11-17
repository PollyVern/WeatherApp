//
//  GlobalWeatherBuilder.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.11.2023.
//

import Foundation

class GlobalWeatherBuilder {

    private var weather: WeatherModel?
    
    private static let sharedInstance = GlobalWeatherBuilder()

    public static func shared() -> GlobalWeatherBuilder {
        return sharedInstance
    }

    func build() -> WeatherModel? {
        return weather
    }

    func setWeatherModel(model: WeatherModel) {
        weather = model
    }
}
