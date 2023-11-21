//
//  JsonConverter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 21.11.2023.
//

import Foundation


class JsonConverter {

    private static let sharedInstance = JsonConverter()

    public static func shared() -> JsonConverter {
        return sharedInstance
    }

    public func convert<T: ApiParameters>(parameters: T) -> [String : Any] {
        let constantsAPI = ConstantsAPI.shared()
        if let weatherParameters = parameters as? WeatherParameters {
            let parameters: [String : Any] = [
                constantsAPI.lat: weatherParameters.lat,
                constantsAPI.lon: weatherParameters.lon,
                constantsAPI.lang: weatherParameters.lang
            ]
            return parameters
        } else {
            return [:]
        }
    }

}
