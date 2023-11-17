//
//  WeatherRequestRouter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Alamofire

enum WeatherRequestRouter: RequestRouter {

    case getWeather(parameters: Parameters)

    var url: URL {
        return URL.init(string: ConstantsAPI.shared().baseUrlString + ConstantsAPI.shared().informersUrlString)!
    }

    var method: HTTPMethod {
        switch self {
        case .getWeather:
            return .get
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getWeather:
            return [ConstantsAPI.shared().yandexApiHeader: ConstantsAPI.shared().weatherKeyAPI]
        }
    }

    var queryParameters: Parameters? {
        switch self {
        case .getWeather(let parameters):
            return parameters
        }
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        urlRequest = try URLEncoding.queryString.encode(urlRequest, with: queryParameters)
        return urlRequest
    }
}
