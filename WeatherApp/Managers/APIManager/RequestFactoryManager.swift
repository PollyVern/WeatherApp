//
//  RequestFactoryManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Alamofire

class RequestFactoryManager {

    private var weatherRequestFactory: WeatherRequestFactory?

    private var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        let session = Session(configuration: configuration)
        return session
    }()

    func makeAuthRequestFactory() -> WeatherRequestFactory {
        if let weatherRequestFactory = weatherRequestFactory {
            return weatherRequestFactory
        } else {
            let weatherRequestFactory = WeatherRequestFactory()
            self.weatherRequestFactory = weatherRequestFactory
            return weatherRequestFactory
        }
    }

}
