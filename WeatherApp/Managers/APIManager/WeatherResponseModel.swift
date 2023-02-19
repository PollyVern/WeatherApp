//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

struct WeatherResponseModel: Codable {
    let geoObject: GeoObject
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case geoObject = "geo_object"
        case forecasts
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

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let parts: Parts

    enum CodingKeys: String, CodingKey {
        case date, parts
    }
}

// MARK: - Parts
struct Parts: Codable {
    let morning: Morning

    enum CodingKeys: String, CodingKey {
        case morning
    }
}

// MARK: - Morning
struct Morning: Codable {
    let temp_avg: Int
    let feels_like: Int
    let wind_speed: Float
    let wind_gust: Float

    enum CodingKeys: String, CodingKey {
        case temp_avg, feels_like, wind_speed, wind_gust
    }
}
