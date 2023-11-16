//
//  WeatherRequestFactory.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Alamofire

final class WeatherRequestFactory {

    private var sessionManager = Session()

    public func getWeather(latitude: String, longitude: String, completion: @escaping (WeatherResponseModel?, AFError?) -> Void) {
        let parameters: [String : Any] = [
            "lat": latitude,
            "lon": longitude,
            "lang": "ru_RU"
        ]

        let request = WeatherRequestRouter.getWeather(parameters: parameters)
        sessionManager.request(request).responseDecodable(of: WeatherResponseModel.self) { response in
            switch response.result {
            case .success(let response):
                print("?? response \(response)")
                completion(response, nil)
                return
            case .failure(let error):
                print("?? error \(error)")
                completion(nil, error)
                return
            }
        }

    }
}
