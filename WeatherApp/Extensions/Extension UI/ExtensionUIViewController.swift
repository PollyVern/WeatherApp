//
//  Extension UINavigationController.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.11.2023.
//

import UIKit

enum DefaultAlertType {
    case error

    var title: String {
        switch self {
        case .error:
            return NSLocalizedString("error_title", comment: "")
        }
    }

    var message: String {
        switch self {
        case .error:
            return NSLocalizedString("error_message_something_went_wrong", comment: "")
        }
    }

    var buttonTitle: String {
        switch self {
        case .error:
            return NSLocalizedString("error_button_repeat_request", comment: "")
        }
    }

}

extension UIViewController {

    func showDefaultAlert(type: DefaultAlertType, buttonAction: @escaping (()->())) {
        let alert = UIAlertController(title: type.title, message: type.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: type.buttonTitle, style: .default, handler: { _ in
            buttonAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

