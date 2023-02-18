//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Combine
import CoreLocation

protocol WeatherViewProtocol {
    func setModel(model: WeatherModel)
    func hideIndicator()
}

class WeatherPresenter {

    // MARK: - Managers and Factory
    private let locationManager: LocationManager
    private var weatherRequestFactory: WeatherRequestFactory?
    private let factory = RequestFactoryManager()

    // MARK: - Protocol
    private var weatherView: WeatherViewProtocol?

    // MARK: - Model
    private var defaultWeatherModel = DefaultWeatherModel()
    private var weatherModel: WeatherModel?

    // MARK: - Combine
    private var cancellable = Set<AnyCancellable>()

    let dispatchGroup = DispatchGroup()

    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        setLocationManager()
    }

    func attachView(view: WeatherViewProtocol) {
        weatherView = view
    }

    func detachView() {
        weatherView = nil
    }

    private func setLocationManager() {
        locationManager.setLocationManager()
        locationManager.$currentLocation
            .sink { [weak self] location in
                guard let self = self,
                      let location = location else {
                    return
                }
                self.setWeatherRequest(latitude: "\(location.coordinate.latitude)", longitude: "\(location.coordinate.longitude)")
                
            }
            .store(in: &cancellable)

        locationManager.$isDetermined
            .sink { [weak self] isDetermined in
                guard let self = self,
                      let isDetermined = isDetermined else {
                    return
                }
                if !isDetermined {
                    self.setWeatherRequest(latitude: self.defaultWeatherModel.latitude, longitude: self.defaultWeatherModel.longitude)
                }
            }
            .store(in: &cancellable)
    }

    private func setWeatherRequest(latitude: String, longitude: String) {
        weatherRequestFactory = factory.makeAuthRequestFactory()
        dispatchGroup.enter()
        weatherRequestFactory?.getWeather(latitude: latitude, longitude: longitude, completion: { model, error in
            guard let model = model else {
                return
            }
            var weatherWeakModel = [WeatherWeakModel]()

            model.forecasts.forEach { element in
                weatherWeakModel.append(WeatherWeakModel(date: element.date,
                                                         temp_avg: element.parts.morning.temp_avg,
                                                         feels_like: element.parts.morning.feels_like))
            }
            self.weatherModel = WeatherModel(country: model.geoObject.country.name,
                                             province: model.geoObject.province.name,
                                             week: weatherWeakModel)


            self.dispatchGroup.leave()
        })

        self.dispatchGroup.notify(queue: .main) {
            guard let weatherModel = self.weatherModel else { return }
            self.weatherView?.hideIndicator()
            self.weatherView?.setModel(model: weatherModel)
        }
    }

}
