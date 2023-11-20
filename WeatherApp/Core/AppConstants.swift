//
//  AppConstants.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 18.11.2023.
//

import Foundation

class AppConstants {

    private static let sharedInstance = AppConstants()

    public static func shared() -> AppConstants {
        return sharedInstance
    }

    let defaultLatitude: Double = 48.8534 // Paris
    let defaultLongitude: Double = 2.3488 // Paris

}
