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

    public func getWeather(latitude: Double, longitude: Double, completion: @escaping (WeatherResponseModel?, AFError?) -> Void) {
        let parameters = JsonConverter.shared().convert(parameters: WeatherParameters(lat: "\(latitude)", lon: "\(longitude)", lang: ConstantsAPI.shared().langRu))

        let request = WeatherRequestRouter.getWeather(parameters: parameters)
        sessionManager.request(request).responseDecodable(of: WeatherResponseModel.self) { [weak self] response in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch response.result {
                case .success(let response):
                    completion(response, nil)
                    return
                case .failure(let error):
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 403 {
                            ConstantsUI.shared().navigationController?.showDefaultAlert(type: .maximumRequest, buttonAction: { [weak self] in
                                guard let _ = self else { return }
                            })
                        }
                    }
                    completion(nil, error)
                    return
                }
            }
        }
    }

}
