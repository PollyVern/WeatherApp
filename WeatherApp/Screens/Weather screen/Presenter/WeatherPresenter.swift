//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Combine
import CoreLocation

protocol WeatherProtocol: AnyObject {
//    func setModel(model: WeatherModel)
//    func hideIndicator()
    func showAPIError(latitude: String, longitude: String)
    func setContentState(state: WeatherViewScreenType)
//    func showInfoAlert()
}

class WeatherPresenter {

    // MARK: - Managers and Factory
    private let locationManager: LocationManager
    private var weatherRequestFactory: WeatherRequestFactory?
    private let factory = RequestFactoryManager()

    // MARK: - Protocol
    private weak var weatherView: WeatherProtocol?

    // MARK: - Model
//    private var defaultWeatherModel = DefaultWeatherModel()
//    private var weatherModel: WeatherModel?

    // MARK: - Combine
    private var cancellable = Set<AnyCancellable>()

    private let dispatchGroup = DispatchGroup()

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        setLocationManager()
    }

    func attachView(view: WeatherProtocol) {
        weatherView = view
    }

    func repeatWeatherRequest(latitude: String, longitude: String) {
        setWeatherRequest(latitude: latitude, longitude: longitude)
    }

//    func detachView() {
////        weatherView = nil
//    }

}


private extension WeatherPresenter {

    private func setLocationManager() {
        locationManager.setLocationManager()
        locationManager.$currentLocation
            .sink { [weak self] location in
                guard let self = self,
                      let location = location else {
                    return
                }
                DispatchQueue.main.async {
                    self.setWeatherRequest(latitude: "\(location.coordinate.latitude)", longitude: "\(location.coordinate.longitude)")
                }

            }
            .store(in: &cancellable)

//        locationManager.$isDetermined
//            .sink { [weak self] isDetermined in
//                guard let self = self,
//                      let isDetermined = isDetermined else {
//                    return
//                }
//                if !isDetermined {
//                    self.setWeatherRequest(latitude: self.defaultWeatherModel.latitude, longitude: self.defaultWeatherModel.longitude)
////                    self.weatherView?.showInfoAlert()
//                }
//            }
//            .store(in: &cancellable)
    }

    func setWeatherRequest(latitude: String, longitude: String) {
        weatherRequestFactory = factory.makeAuthRequestFactory()
        dispatchGroup.enter()
        weatherRequestFactory?.getWeather(latitude: latitude, longitude: longitude, completion: { [weak self] model, error in
            guard let self = self,
                  let model = model,
                  let locationValue = locationManager.getCountryAndCity() else {
                self?.weatherView?.showAPIError(latitude: latitude, longitude: longitude)
                self?.dispatchGroup.leave()
                return
            }

            var parts = [WeatherPartModel]()
            model.forecast.parts.forEach { part in
                parts.append(WeatherPartModel(temp_avg: part.temp_avg,
                                              feels_like: part.feels_like,
                                              wind_speed: part.wind_speed,
                                              wind_gust: part.wind_gust))
            }
            let weatherModel = WeatherModel(country: locationValue.0,
                                            city: locationValue.1,
                                            date: model.forecast.date,
                                            parts: parts)
            GlobalWeatherBuilder.shared().setWeatherModel(model: weatherModel)
            self.dispatchGroup.leave()
        })

        self.dispatchGroup.notify(queue: .main) {
            guard let weatherModel = GlobalWeatherBuilder.shared().build() else { return }
            self.weatherView?.setContentState(state: .contentViewState(model: weatherModel))
        }
    }

}
