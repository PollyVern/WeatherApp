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
    func showAPIErrorAlert(latitude: Double, longitude: Double)
    func showInfoAlert()
    func showApiKeyAlert()
    func setContentState(state: WeatherViewScreenType)
}

class WeatherPresenter {

    // MARK: - Managers and Factory
    private let locationManager: LocationManager = LocationManager.shared()
    private var weatherRequestFactory: WeatherRequestFactory?
    private let factory = RequestFactoryManager()

    // MARK: - Protocol
    private weak var weatherView: WeatherProtocol?

    // MARK: - Combine
    private var cancellable = Set<AnyCancellable>()

    private let dispatchGroup = DispatchGroup()

    func attachView(view: WeatherProtocol) {
        weatherView = view
        checkEEnvironmentXCodeKey()
        setLocationManager()
    }

    func repeatWeatherRequest(latitude: Double, longitude: Double) {
        setWeatherRequest(latitude: latitude, longitude: longitude)
    }

}


private extension WeatherPresenter {

    func checkEEnvironmentXCodeKey() {
        if ConstantsAPI.shared().weatherKeyAPI.isEmpty {
            self.weatherView?.showApiKeyAlert()
        }
    }

    func setLocationManager() {
        locationManager.setLocationManager()
        locationManager.$currentLocation
            .sink { [weak self] location in
                guard let self = self,
                      let location = location else {
                    return
                }
                DispatchQueue.main.async {
                    self.setWeatherRequest(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
                }

            }
            .store(in: &cancellable)

        locationManager.$isDetermined
            .sink { [weak self] isDetermined in
                guard let self = self,
                      let isDetermined = isDetermined else {
                    return
                }
                if !isDetermined {
                    self.setWeatherRequest(latitude: AppConstants.shared().defaultLatitude, longitude: AppConstants.shared().defaultLongitude)
                    self.weatherView?.showInfoAlert()
                }
            }
            .store(in: &cancellable)
    }

    func setWeatherRequest(latitude: Double, longitude: Double) {
        weatherRequestFactory = factory.makeAuthRequestFactory()
        dispatchGroup.enter()
        weatherRequestFactory?.getWeather(latitude: latitude, longitude: longitude, completion: { [weak self] model, error in
            guard let self = self,
                  let model = model,
                  let locationValue = locationManager.getLocationValue() else {
                self?.dispatchGroup.leave()
                return
            }
            var parts = [WeatherPartModel]()
            model.forecasts.forEach { forecast in
                parts.append(WeatherPartModel(date: forecast.date,
                                              temp_avg: forecast.parts.morning.temp_avg,
                                              feels_like: forecast.parts.morning.feels_like,
                                              wind_speed: forecast.parts.morning.wind_speed,
                                              wind_gust: forecast.parts.morning.wind_gust))
            }

            let weatherModel = WeatherModel(country: locationValue.0,
                                            city: locationValue.1,
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
