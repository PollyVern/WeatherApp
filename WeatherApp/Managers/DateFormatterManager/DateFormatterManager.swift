//
//  DateFormatterManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 18.02.2023.
//

import Foundation


class DateFormatterManager {

    private static let sharedInstance = DateFormatterManager()

    public static func shared() -> DateFormatterManager {
        return sharedInstance
    }

    func refactorDate(dateInString: String, formatType: FormatterSetType) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = FormatterSetType.getApiDate.format

        if let date = dateFormatterGet.date(from: dateInString) {
            let dateFormatterSet = DateFormatter()
            dateFormatterSet.dateFormat = formatType.format

            dateFormatterSet.locale = Locale(identifier: AppConstants.shared().localeIdentifier)
            return dateFormatterSet.string(from: date)
        }
        return nil
    }
}
