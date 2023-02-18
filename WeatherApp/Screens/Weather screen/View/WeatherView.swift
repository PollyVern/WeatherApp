//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit
import SnapKit

protocol WeatherViewProtocol {
    func setModel(model: WeatherModel)
}

class WeatherView: UIView {

    // MARK: - Model
    private var model: WeatherModel?

    // MARK: - Managers
    private var dateFormatterManager: DateFormatterManager?
    private let factoryManager = FactoryManager()

    // MARK: - UI
    private(set) lazy var localLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = UIColor.textColor
        return label
    }()

    private(set) lazy var blueRectangleView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.lightBlueColor
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
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = UIColor.backgroundColor

        // localLabel
        self.addSubview(localLabel)
        localLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(70)
            make.leading.equalToSuperview().inset(20)
        }
        localLabel.layoutIfNeeded()

        // blueRectangleView
        self.addSubview(blueRectangleView)
        blueRectangleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(localLabel.snp.bottom).offset(30)
        }
        blueRectangleView.layoutIfNeeded()
        blueRectangleView.snp.makeConstraints { make in
            make.height.equalTo(blueRectangleView.snp.width)
        }

        // dateLabel
        blueRectangleView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }

    func setData(model: WeatherModel) {
        self.model = model
        localLabel.text = "\(model.province.uppercased()), \n\(model.country)"

        dateFormatterManager = factoryManager.makeDateFormatterManager()
        guard let dateFormatterManager = dateFormatterManager else { return }
        dateLabel.text = dateFormatterManager.refactorDate(date: model.week[0].date)

    }

}
