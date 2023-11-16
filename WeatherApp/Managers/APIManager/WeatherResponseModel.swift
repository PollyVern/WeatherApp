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

// MARK: - Forecast
struct Forecast: Codable {
    let date: String
    let parts: [Parts]

    enum CodingKeys: String, CodingKey {
        case date, parts
    }
}

// MARK: - Parts
struct Parts: Codable {
    let part_name: String

    enum CodingKeys: String, CodingKey {
        case part_name
    }
}
