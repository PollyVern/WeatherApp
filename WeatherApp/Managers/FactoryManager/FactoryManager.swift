//
//  FactoryManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import CoreLocation


class FactoryManager {

    private var locationManager: CLLocationManager?
    private var dateFormatterManager: DateFormatterManager?

    func makeLocationManager() -> CLLocationManager {
        if let factory = locationManager {
            return factory
        } else {
            let factory = CLLocationManager()
            locationManager = factory
            return factory
        }
    }

    func makeDateFormatterManager() -> DateFormatterManager {
        if let factory = dateFormatterManager {
            return factory
        } else {
            let factory = DateFormatterManager()
            dateFormatterManager = factory
            return factory
        }
    }

}
