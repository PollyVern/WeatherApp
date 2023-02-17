//
//  WeatherResponseModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation

// MARK: - Welcome
struct WeatherResponseModel: Codable {
    let now: Int
    let nowDt: String
    let info: Info

    enum CodingKeys: String, CodingKey {
        case now
        case nowDt = "now_dt"
        case info
    }
}

// MARK: - Info
struct Info: Codable {
    let lat, lon: Double
    let tzinfo: Tzinfo
    let defPressureMm, defPressurePa: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case lat, lon, tzinfo
        case defPressureMm = "def_pressure_mm"
        case defPressurePa = "def_pressure_pa"
        case url
    }
}

// MARK: - Tzinfo
struct Tzinfo: Codable {
    let offset: Int
    let name, abbr: String
    let dst: Bool
}
