//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit


// MARK: - Controller
class WeatherViewController: UIViewController {

    private var weatherView: WeatherViewProtocol = WeatherView(state: .activityIndicatorState)
    private let presenter = WeatherPresenter(locationManager: LocationManager.shared())

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        setupUI()
    }
}

// MARK: - Private extension
private extension WeatherViewController {

    func setupUI() {
        self.view.addSubview(weatherView)
        weatherView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }

}

// MARK: - Protocol
extension WeatherViewController: WeatherProtocol {
    func setContentState(state: WeatherViewScreenType) {
        self.weatherView.changeContentState(state: state)
    }
    
//    func showInfoAlert() {
////        let alert = UIAlertController(title: "Ой!", message: "В геолокации отказано. Показываю город по дефолту - Москва", preferredStyle: .alert)
////        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: { _ in }))
////        self.present(alert, animated: true, completion: nil)
//    }

    func showAPIError(latitude: String, longitude: String) {
        self.showDefaultAlert(type: .error) { [weak self] in
            guard let self = self else { return }
            self.presenter.repeatWeatherRequest(latitude: latitude, longitude: longitude)
        }
    }
//
//    func showIndicator() {
////        activityIndicator.isHidden = false
////        self.view = nil
//    }
//
//    func hideIndicator() {
////        activityIndicator.isHidden = true
////        self.view = self.weatherView
//    }

//    func setModel(model: WeatherModel) {
////        self.weatherView?.setData(model: model, index: 0)
//    }


}
