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

    private let constantsAPI = ConstantsAPI.shared()

    public func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponseModel?, AFError?) -> Void) {
        let parameters: [String : Any] = [
            constantsAPI.lat: "\(latitude)",
            constantsAPI.lon: "\(longitude)",
            constantsAPI.lang: constantsAPI.langRu
        ]

        let request = WeatherRequestRouter.getWeather(parameters: parameters)
        sessionManager.request(request).responseDecodable(of: WeatherResponseModel.self) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
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

}
