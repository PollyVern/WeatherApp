//
//  DateFormatterModel.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.11.2023.
//

import Foundation

enum FormatterSetType {
    case fullDate
    case dateWithoutYear
    case getApiDate

    var format: String {
        switch self {
        case .fullDate:
            return "dd MMMM yyyy"
        case .dateWithoutYear:
            return "dd MMMM"
        case .getApiDate:
            return "yyyy-MM-dd"
        }
    }
}
