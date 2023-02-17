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

    private var localLabel: UILabel = {
        var label = UILabel()
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
        self.backgroundColor = .red

        self.addSubview(localLabel)
        localLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(40)
        }
//        print("?? model?.country \(model?.country)")
    }

    func setData(model: WeatherModel) {
        localLabel.text = model.country
    }

}
