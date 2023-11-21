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
    private let presenter = WeatherPresenter()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

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

        weatherView.delegate = self
    }
}

// MARK: - Protocol
extension WeatherViewController: WeatherProtocol {
    func setContentState(state: WeatherViewScreenType) {
        self.weatherView.changeContentState(state: state)
    }
    
    func showInfoAlert() {
        self.showDefaultAlert(type: .geolocationDenied) { [ weak self] in
            guard let _ = self else { return }
        }
    }

    func showAPIErrorAlert(latitude: Double, longitude: Double) {
        self.showDefaultAlert(type: .error) { [weak self] in
            guard let self = self else { return }
            self.presenter.repeatWeatherRequest(latitude: latitude, longitude: longitude)
        }
    }

    func showApiKeyAlert() {
        self.showDefaultAlert(type: .apiKeyError) { [weak self] in
            guard let self = self else { return }
            ApplicationSharedManager.shared().goToAnyLink(type: .weatherAppRepository)
            self.weatherView.changeContentState(state: .linkToGithubRepository)
        }
    }
}

// MARK: - Delegate
extension WeatherViewController: WeatherViewDelegate {
    func tapOnSelf() {
        ApplicationSharedManager.shared().goToAnyLink(type: .weatherAppRepository)
    }
}
