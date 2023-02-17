//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

struct WeatherResponseModel: Codable {
    let geoObject: GeoObject

    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
    }
}

// MARK: - GeoObject
struct GeoObject: Codable {
    let province, country: Country
}

// MARK: - Country
struct Country: Codable {
    let name: String
}
