//
//  SmallerWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 19.02.2023.
//

import UIKit
import SnapKit

class SmallerWeatherCollectionViewCell: UICollectionViewCell {

    // MARK: - Managers
    private var dateFormatterManager: DateFormatterManager?
    private let factoryManager = FactoryManager()

    // MARK: - UI
    private let background: UIView = {
        let view = UIView()
        view.backgroundColor = .darkBlueColor
        view.layer.cornerRadius = 10
        return view
    }()

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()

    private(set) lazy var tempLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.textColor = .white
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    private func setupUI() {

        // background
        self.addSubview(background)
        background.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // dateLabel
        background.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.leading.trailing.equalToSuperview().inset(10)
        }

        // tempLabel
        background.addSubview(tempLabel)
        tempLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }

    }

    func setData(model: WeatherWeakModel) {
        dateFormatterManager = factoryManager.makeDateFormatterManager()
        guard let dateFormatterManager = dateFormatterManager else { return }
        dateLabel.text = dateFormatterManager.refactorDate(date: model.date, formatType: .dateWithoutYear)

        tempLabel.text = "\(model.temp_avg) °C"
        
    }

    func setSelectedCell() {
        background.layer.borderWidth = 3.0
        background.layer.borderColor = UIColor.lightBlueColor.cgColor
    }

    func setDeselectedCell() {
        background.layer.borderWidth = 0.0
        background.layer.borderColor = UIColor.clear.cgColor
    }

}
