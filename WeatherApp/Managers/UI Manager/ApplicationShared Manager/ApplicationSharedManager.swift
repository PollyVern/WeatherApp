//
//  ApplicationSharedManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 20.11.2023.
//

import UIKit

enum ApplicationSharedTypes: String {
    case weatherAppRepository = "https://github.com/PollyVern/WeatherApp"
}

class ApplicationSharedManager {

    private static let sharedInstance = ApplicationSharedManager()

    public static func shared() -> ApplicationSharedManager {
        return sharedInstance
    }

    func goToAnyLink(type: ApplicationSharedTypes) {
        if let url = URL(string: type.rawValue) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:]) { _ in
                }
            }
        }
    }

}
