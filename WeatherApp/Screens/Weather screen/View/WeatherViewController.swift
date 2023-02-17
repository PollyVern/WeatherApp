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

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self)
        weatherView = WeatherView(frame: self.view.frame)
        self.view = weatherView
    }

}

extension WeatherViewController: WeatherViewProtocol {
    func setModel(model: WeatherModel) {
        weatherView?.setData(model: model)
    }


}
