//
//  WeatherViewScreenType.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.11.2023.
//

import Foundation

enum WeatherViewScreenType {
    case activityIndicatorState
    case contentViewState(model: WeatherModel)
    case linkToGithubRepository
}
