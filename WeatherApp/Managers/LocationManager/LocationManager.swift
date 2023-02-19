//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import CoreLocation
import Combine

class LocationManager: NSObject {

    // MARK: - Managers
    private var locationManager: CLLocationManager?
    private let factoryManager = FactoryManager()

    // MARK: - Properties
    @Published var currentLocation: CLLocation?
    @Published var isDetermined: Bool?

    func setLocationManager() {
        locationManager = factoryManager.makeLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.delegate = self
        locationManager.requestLocation()
    }

    private func checkLocationStatus() {
        guard let locationManager = locationManager else { return }
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            isDetermined = true
            print("❖ authorizationStatus: authorizedAlways")
        case .denied:
            print("❖ authorizationStatus: denied")
            isDetermined = false
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            isDetermined = nil
            print("❖ authorizationStatus: notDetermined")
        case .restricted:
            isDetermined = true
            print("❖ authorizationStatus: restricted")
        @unknown default:
            isDetermined = false
            print("❖ authorizationStatus: default")
        }

    }

}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        if currentLocation == nil {
            currentLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            manager.stopUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager?.requestLocation()
        }
    }
}
