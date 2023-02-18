//
//  DateFormatterManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 18.02.2023.
//

import Foundation

final class DateFormatterManager {

    func refactorDate(date: String) -> String? {

        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-mm-dd"

        let dateFormatterSet = DateFormatter()
        dateFormatterSet.locale = Locale(identifier: "RU")
        dateFormatterSet.dateFormat = "dd MMMM yyyy"

        if let date = dateFormatterGet.date(from: date) {
            return dateFormatterSet.string(from: date)
        } else {
            return nil
        }
    }
}
