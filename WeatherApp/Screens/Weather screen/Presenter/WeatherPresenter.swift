//
//  WeatherPresenter.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import Foundation
import Combine
import CoreLocation


class WeatherPresenter {

    // MARK: - Managers and Factory
    private let locationManager: LocationManager
    private var weatherRequestFactory: WeatherRequestFactory?
    private let factory = RequestFactoryManager()

    // MARK: - Protocol
    private var weatherView: WeatherViewProtocol?

    // MARK: - Model
    private var defaultWeatherModel = DefaultWeatherModel()

    // MARK: - Combine
    private var cancellable = Set<AnyCancellable>()


    init(locationManager: LocationManager) {
        self.locationManager = locationManager
        setLocationManager()
    }

    func attachView(view: WeatherViewProtocol) {
        weatherView = view
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
        weatherRequestFactory?.getWeather(latitude: latitude, longitude: longitude, completion: { model, error in
            guard let model = model else {
                return
            }
            var weatherWeakModel = [WeatherWeakModel]()
            model.forecasts.forEach { element in
                weatherWeakModel.append(WeatherWeakModel(date: element.date))
            }
            self.weatherView?.setModel(model: WeatherModel(country: model.geoObject.country.name,
                                                           province: model.geoObject.province.name,
                                                           week: weatherWeakModel))
        })

    }

}
