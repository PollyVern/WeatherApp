//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

struct WeatherResponseModel: Codable {
    let forecast: Forecast

    enum CodingKeys: String, CodingKey {
        case forecast
    }
}

struct Forecast: Codable {
    let date: String
    let parts: [Parts]

    enum CodingKeys: String, CodingKey {
        case date, parts
    }
}

struct Parts: Codable {
    let part_name: String
    let temp_avg: Int
    let feels_like: Int
    let wind_speed: Float
    let wind_gust: Float

    enum CodingKeys: String, CodingKey {
        case part_name, temp_avg, feels_like, wind_speed, wind_gust
    }
}
