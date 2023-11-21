//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit
import SnapKit


// MARK: - Delegate
protocol WeatherViewDelegate: AnyObject {
    func tapOnSelf()
}

// MARK: - Protocol
protocol WeatherViewProtocol: UIView {
    var delegate: WeatherViewDelegate? { get set }
    func changeContentState(state: WeatherViewScreenType)
}

// MARK: - View
class WeatherView: UIView {

    weak var delegate: WeatherViewDelegate?

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

    private var collectionView: MainCardsCollectionViewProtocol?

    private(set) lazy var gitHubPlugView: GithubPlugViewProtocol = {
        let view = GithubPlugView()
        view.delegate = self
        return view
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

// MARK: - View Protocol
extension WeatherView: WeatherViewProtocol {
    func changeContentState(state: WeatherViewScreenType) {
        switch state {
        case .activityIndicatorState:
            setActivityIndicator(show: true)
        case .contentViewState(let model):
            setActivityIndicator(show: false)
            setupUI(model: model)
            setupData(model: model, index: 0)
        case .linkToGithubRepository:
            setActivityIndicator(show: false)
            setupGithubView()
        }
    }
}

// MARK: - Private extension
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

    func setupUI(model: WeatherModel) {
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
        collectionView = MainCardsCollectionView(model: model)
        guard let collectionView = collectionView else { return }
        collectionView.mainCardsDelegate = self
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(blueRectangleView.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
    }

    func setupGithubView() {
        self.addSubview(gitHubPlugView)
        gitHubPlugView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }
    }
}

// MARK: - Github plug view Delegate
extension WeatherView: GithubPlugViewDelegate {
    func tapOnSelf() {
        delegate?.tapOnSelf()
    }
}

// MARK: - Custom collection view Delegate
extension WeatherView: MainCardsCollectionViewDelegate {
    func setupData(model: WeatherModel, index: Int) {
        self.model = model
        localLabel.text = "\(model.city.uppercased()), \n\(model.country)"
        dateLabel.text = dateFormatterManager.refactorDate(dateInString: model.parts[index].date, formatType: .fullDate)
        tempLabel.text = "\(model.parts[index].temp_avg)" + " " + NSLocalizedString("degrees", comment: "")
        tempFeelsLabel.text = String(format: NSLocalizedString("perceived_temperature", comment: ""), "\(model.parts[index].feels_like)")
        windSpeedLabel.text = String(format: NSLocalizedString("wind_speed", comment: ""), "\(model.parts[index].wind_speed)")
        windGustLabel.text = String(format: NSLocalizedString("speed_of_wind_gusts", comment: ""), "\(model.parts[index].wind_gust)")
    }
}
