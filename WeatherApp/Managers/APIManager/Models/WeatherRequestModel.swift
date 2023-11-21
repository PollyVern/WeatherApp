//
//  WeatherRequestModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 21.11.2023.
//

import Foundation

protocol ApiParameters {}

struct WeatherParameters: ApiParameters {
    let lat: String
    let lon: String
    let lang: String
}
