//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import CoreLocation
import Combine

class LocationManager: NSObject {

    // MARK: Singleton
    private static let sharedInstance = LocationManager()

    // MARK: Managers
    private var defaultLocationManager: CLLocationManager?
    private let factoryManager = FactoryManager()

    // MARK: Public properties
    @Published var currentLocation: CLLocation?
    @Published var isDetermined: Bool?

    // MARK: Private properties
    private var locationValue: (String, String)?

    public static func shared() -> LocationManager {
        return sharedInstance
    }

    func setLocationManager() {
        defaultLocationManager = factoryManager.makeDefaultLocationManager()
        guard let defaultLocationManager = defaultLocationManager else { return }
        defaultLocationManager.delegate = self
        defaultLocationManager.requestLocation()
    }

    func getLocationValue() -> (String, String)? {
        return locationValue
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
            setCountryAndCity()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {}

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            defaultLocationManager?.requestLocation()
        }
    }
}

private extension LocationManager {

    func checkLocationStatus() {
        guard let defaultLocationManager = defaultLocationManager else { return }
        switch defaultLocationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            defaultLocationManager.startUpdatingLocation()
            isDetermined = true
            print("❖ LocationManager authorizationStatus: authorizedAlways")
        case .denied:
            print("❖ LocationManager authorizationStatus: denied")
            isDetermined = false
            setCountryAndCity()
        case .notDetermined:
            defaultLocationManager.requestWhenInUseAuthorization()
            isDetermined = nil
            print("❖ LocationManager authorizationStatus: notDetermined")
        case .restricted:
            isDetermined = true
            print("❖ LocationManager authorizationStatus: restricted")
        @unknown default:
            isDetermined = false
            print("❖ LocationManager authorizationStatus: default")
        }
    }

    func setCountryAndCity() {
        let currentLocation = currentLocation ?? CLLocation(latitude: AppConstants.shared().defaultLatitude, longitude: AppConstants.shared().defaultLongitude)
        CLGeocoder().reverseGeocodeLocation(currentLocation, completionHandler: { [weak self] placemark, _ in
            guard let self = self else { return }
            if let country = placemark?.first?.country,
               let city = placemark?.first?.locality {
                self.locationValue = (country, city)
            }
        })
    }

}
