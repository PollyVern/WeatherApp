//
//  WeatherRequestFactory.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Alamofire

final class WeatherRequestFactory {

    var sessionManager = Session()

    public func getWeather(lat: String, lon: String, completion: @escaping (WeatherResponseModel?, AFError?) -> Void) {
        let parameters: [String : Any] = [
            "lat": lat,
            "lon": lon
        ]

        let request = WeatherRequestRouter.getWeather(parameters: parameters)
        sessionManager.request(request).responseDecodable(of: WeatherResponseModel.self) { response in
            switch response.result {
            case .success(let response):
                completion(response, nil)
                return
            case .failure(let error):
                completion(nil, error)
                return
            }
        }

    }
}
