//
//  ConstantsUI.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 20.11.2023.
//

import UIKit

class ConstantsUI {

    private static let sharedInstance = ConstantsUI()

    public static func shared() -> ConstantsUI {
        return sharedInstance
    }

    let navigationController: UINavigationController? = {
        let keyWindow = UIApplication.shared.connectedScenes.compactMap { ($0 as? UIWindowScene)?.keyWindow }.first(where: { $0.isKeyWindow })
        return keyWindow?.rootViewController as? UINavigationController
    }()


    var navigationBarHeight: CGFloat {
        return self.navigationController?.navigationBar.frame.height ?? 0.0
    }

}
