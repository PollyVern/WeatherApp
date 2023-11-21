//
//  FactoryManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import CoreLocation


class FactoryManager {

    private var defaultLocationManager: CLLocationManager?
    private var dateFormatterManager: DateFormatterManager?

    func makeDefaultLocationManager() -> CLLocationManager {
        if let factory = defaultLocationManager {
            return factory
        } else {
            let factory = CLLocationManager()
            defaultLocationManager = factory
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
