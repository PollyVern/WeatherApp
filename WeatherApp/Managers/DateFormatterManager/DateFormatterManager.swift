//
//  DateFormatterManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 18.02.2023.
//

import Foundation

enum FormatterSetType {
    case fullDate
    case dateWithoutYear

    var format: String {
        switch self {
        case .fullDate:
            return "dd MMMM yyyy"
        case .dateWithoutYear:
            return "dd MMMM"
        }
    }
}

final class DateFormatterManager {

    func refactorDate(date: String, formatType: FormatterSetType) -> String? {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-mm-dd"

        let dateFormatterSet = DateFormatter()
        dateFormatterSet.locale = Locale(identifier: "RU")
        dateFormatterSet.dateFormat = formatType.format

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterSet.string(from: date)
        } else {
            return nil
        }
    }
}
