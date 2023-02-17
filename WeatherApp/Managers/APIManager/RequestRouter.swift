//
//  RequestRouter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Alamofire

protocol RequestRouter: URLRequestConvertible {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var queryParameters: Parameters? { get }
}
