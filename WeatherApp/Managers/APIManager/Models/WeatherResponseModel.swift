//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

// MARK: - Struct
struct WeatherResponseModel: Codable {
    let forecasts: [Forecast]

    enum CodingKeys: String, CodingKey {
        case forecasts
    }
}

struct Forecast: Codable {
    let date: String
    let parts: Parts

    enum CodingKeys: String, CodingKey {
        case date, parts
    }
}

struct Parts: Codable {
    let morning: Morning

    enum CodingKeys: String, CodingKey {
        case morning
    }
}

struct Morning: PartsDayProtocol {
    var temp_avg: Int
    var feels_like: Int
    var wind_speed: Float
    var wind_gust: Float
}

// MARK: - Protocols
protocol PartsDayProtocol: Codable {
    var temp_avg: Int { get set }
    var feels_like: Int { get set }
    var wind_speed: Float { get set }
    var wind_gust: Float { get set }
}
