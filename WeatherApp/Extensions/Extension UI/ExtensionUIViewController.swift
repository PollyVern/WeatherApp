//
//  Extension UINavigationController.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.11.2023.
//

import UIKit

enum DefaultAlertType {
    case error
    case geolocationDenied
    case apiKeyError

    var title: String {
        switch self {
        case .error:
            return NSLocalizedString("error_title", comment: "")
        case .geolocationDenied:
            return NSLocalizedString("info_alert_oops_title", comment: "")
        case .apiKeyError:
            return NSLocalizedString("info_api_key_error_title", comment: "")
        }
    }

    var message: String {
        switch self {
        case .error:
            return NSLocalizedString("error_message_something_went_wrong", comment: "")
        case .geolocationDenied:
            return NSLocalizedString("info_alert_message_geolocation_denied", comment: "")
        case .apiKeyError:
            return NSLocalizedString("info_api_key_error_message", comment: "")
        }
    }

    var buttonTitle: String {
        switch self {
        case .error:
            return NSLocalizedString("error_button_repeat_request", comment: "")
        case .geolocationDenied:
            return NSLocalizedString("info_button_ok", comment: "")
        case .apiKeyError:
            return NSLocalizedString("info_api_key_error_button_title", comment: "")
        }
    }

}

extension UIViewController {

    func showDefaultAlert(type: DefaultAlertType, buttonAction: @escaping (()->())) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: type.buttonTitle, style: .destructive, handler: { _ in
            buttonAction()
        }))
        self.present(alert, animated: true, completion: nil)

    }
}

