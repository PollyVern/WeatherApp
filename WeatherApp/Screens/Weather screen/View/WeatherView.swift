//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit
import SnapKit


// MARK: Protocol
protocol WeatherViewProtocol: UIView {

    func changeContentState(state: WeatherViewScreenType)

}

class WeatherView: UIView {

    // MARK: Model
    private var model: WeatherModel?

    // MARK: Managers
    private var dateFormatterManager = DateFormatterManager.shared()

    // MARK: Init view
    private var state: WeatherViewScreenType

    // MARK: - UI
    private(set) var activityIndicator: UIActivityIndicatorView?

    private(set) lazy var localLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = .textColor
        return label
    }()

    private(set) lazy var blueRectangleView: UIView = {
        var view = UIView()
        view.backgroundColor = .lightBlueColor
        view.layer.cornerRadius = 30
        return view
    }()

    private(set) lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()

    private(set) lazy var tempLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 80)
        label.textColor = .white
        return label
    }()

    private(set) lazy var tempFeelsLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var windSpeedLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var windGustLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayoutManager.shared().createCollectionViewLayout(leading: 20, trailing: 20, height: 200, width: UIScreen.main.bounds.width/3, spacing: 8))
        collectionView.register(SmallerWeatherCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SmallerWeatherCollectionViewCell.self))
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.alwaysBounceVertical = false
        return collectionView

    }()

    init(state: WeatherViewScreenType) {
        self.state = state
        super.init(frame: .zero)
        self.backgroundColor = .backgroundColor
        changeContentState(state: .activityIndicatorState)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else { return 1 }
        return model.parts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SmallerWeatherCollectionViewCell.self), for: indexPath) as? SmallerWeatherCollectionViewCell
        guard let cell = cell,
              let model = model else { return UICollectionViewCell() }
        cell.setData(model: model.parts[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        guard  let model = model else { return }
//        setData(model: model, index: indexPath.row)
//
//        if let cell = collectionView.cellForItem(at: indexPath) as? SmallerWeatherCollectionViewCell {
//            cell.setSelectedCell()
//        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SmallerWeatherCollectionViewCell else {
            return
        }
        cell.setDeselectedCell()
    }

}

extension WeatherView: WeatherViewProtocol {

    func changeContentState(state: WeatherViewScreenType) {
        switch state {
        case .activityIndicatorState:
            setActivityIndicator(show: true)
        case .contentViewState(let model):
            setActivityIndicator(show: false)
            setupUI()
            setupData(model: model)
        }
    }

}

private extension WeatherView {

    func setActivityIndicator(show: Bool) {
        if show {
            if activityIndicator == nil {
                activityIndicator = UIActivityIndicatorView()
                guard let activityIndicator = activityIndicator else { return }
                activityIndicator.style = .large
                activityIndicator.isHidden = false
                activityIndicator.color = .gray
                activityIndicator.startAnimating()
                self.addSubview(activityIndicator)
                activityIndicator.snp.makeConstraints {$0.center.equalToSuperview()}
            }
        } else {
            activityIndicator?.removeFromSuperview()
            activityIndicator = nil
        }
    }

    func setupUI() {
        self.backgroundColor = .backgroundColor

        // localLabel
        self.addSubview(localLabel)
        localLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(70)
            make.height.equalTo(60)
            make.leading.equalToSuperview().inset(20)
        }

        // blueRectangleView
        self.addSubview(blueRectangleView)
        blueRectangleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(localLabel.snp.bottom).offset(30)
        }

        // dateLabel
        blueRectangleView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }

        // tempLabel
        blueRectangleView.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

        // tempFeelsLabel
        blueRectangleView.addSubview(tempFeelsLabel)
        tempFeelsLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        // windSpeedLabel
        blueRectangleView.addSubview(windSpeedLabel)
        windSpeedLabel.snp.makeConstraints { make in
            make.top.equalTo(tempFeelsLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        // windGustLabel
        blueRectangleView.addSubview(windGustLabel)
        windGustLabel.snp.makeConstraints { make in
            make.top.equalTo(windSpeedLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }

        // collection
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(blueRectangleView.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
    }

    func setupData(model: WeatherModel) {
        self.model = model
        localLabel.text = "\(model.city.uppercased()), \n\(model.country)"
        dateLabel.text = dateFormatterManager.refactorDate(date: model.date, formatType: .fullDate)
        if let temp_avg = model.parts.first?.temp_avg {
            tempLabel.text = "\(temp_avg)" + " " + NSLocalizedString("degrees", comment: "")
        }
        if let feels_like = model.parts.first?.feels_like {
            tempFeelsLabel.text = String(format: NSLocalizedString("perceived_temperature", comment: ""), "\(feels_like)")
        }
        if let wind_speed = model.parts.first?.wind_speed {
            windSpeedLabel.text = String(format: NSLocalizedString("wind_speed", comment: ""), "\(wind_speed)")
        }
        if let wind_gust = model.parts.first?.wind_gust {
            windGustLabel.text = String(format: NSLocalizedString("speed_of_wind_gusts", comment: ""), "\(wind_gust)")
        }
    }

}
