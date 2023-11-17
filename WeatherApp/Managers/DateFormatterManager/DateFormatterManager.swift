//
//  DateFormatterManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 18.02.2023.
//

import Foundation


class DateFormatterManager {

    private static let sharedInstance = DateFormatterManager()

    private let localeIdentifier = "RU"

    public static func shared() -> DateFormatterManager {
        return sharedInstance
    }

    func refactorDate(date: String, formatType: FormatterSetType) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = FormatterSetType.getApiDate.format

        let dateFormatterSet = DateFormatter()
        dateFormatterSet.locale = Locale(identifier: localeIdentifier)
        dateFormatterSet.dateFormat = formatType.format

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterSet.string(from: date)
        } else {
            return nil
        }
    }
}
