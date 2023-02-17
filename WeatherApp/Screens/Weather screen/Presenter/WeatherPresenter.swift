//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

class WeatherPresenter {

    private let locationManager: LocationManager

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        setLocationManager()
    }

    func setLocationManager() {
        locationManager.setLocationManager()
    }

}
