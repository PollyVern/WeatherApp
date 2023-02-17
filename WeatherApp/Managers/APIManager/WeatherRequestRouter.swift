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
        return URL.init(string: RequestProperties.baseUrl.rawValue + "/forecast")!
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
            return ["X-Yandex-API-Key": RequestProperties.keyAPI.rawValue]
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
