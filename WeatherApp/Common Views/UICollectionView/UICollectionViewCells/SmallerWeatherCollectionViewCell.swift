//
//  SmallerWeatherCollectionViewCell.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 19.02.2023.
//

import UIKit
import SnapKit

protocol SmallerWeatherCollectionViewProtocol: UICollectionViewCell {
    func setData(model: WeatherPartModel)
    func deselectedCell()
    func selectedCell()
}

class SmallerWeatherCollectionViewCell: UICollectionViewCell {

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

}

private extension SmallerWeatherCollectionViewCell {
    func setupUI() {
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
}

extension SmallerWeatherCollectionViewCell: SmallerWeatherCollectionViewProtocol {

    func setData(model: WeatherPartModel) {
        dateLabel.text = DateFormatterManager.shared().refactorDate(dateInString: model.date, formatType: .dateWithoutYear)
        tempLabel.text =  "\(model.temp_avg)" + " " + NSLocalizedString("degrees", comment: "")
    }

    func deselectedCell() {
        background.layer.borderWidth = 0.0
        background.layer.borderColor = UIColor.clear.cgColor
    }

    func selectedCell() {
        background.layer.borderWidth = 3.0
        background.layer.borderColor = UIColor.lightBlueColor.cgColor
    }
}
