//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit

class WeatherViewController: UIViewController {

    private var weatherView: WeatherView? = nil
    private let presenter = WeatherPresenter(locationManager: LocationManager())

    private(set) lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.center = self.view.center
        activityIndicator.style = .large
        activityIndicator.isHidden = false
        activityIndicator.color = .gray
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = .backgroundColor

        // weatherView
        weatherView = WeatherView(frame: self.view.frame)

        // activityIndicator
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        activityIndicator.startAnimating()
    }

}

extension WeatherViewController: WeatherViewProtocol {
    func showIndicator() {
        activityIndicator.isHidden = false
        self.view = nil
    }

    func hideIndicator() {
        activityIndicator.isHidden = true
        self.view = self.weatherView
    }

    func setModel(model: WeatherModel) {
        self.weatherView?.setData(model: model, index: 0)
    }


}
