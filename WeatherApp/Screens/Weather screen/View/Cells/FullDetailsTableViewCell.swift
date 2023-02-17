//
//  FullDetailsTableViewCell.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit
import SnapKit

class FullDetailsTableViewCell: UITableViewCell {

    private var dateFormatterManager: DateFormatterManager?
    private let factoryManager = FactoryManager()

    private(set) lazy var blueRectangleView: UIView = {
        var view = UIView()
        view.backgroundColor = .systemBlue
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {

        // blueRectangleView
        self.addSubview(blueRectangleView)
        blueRectangleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(300)
        }
        blueRectangleView.layoutIfNeeded()

        // dateLabel
        blueRectangleView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(20)
        }
    }

    func setData(model: WeatherModel) {
        dateFormatterManager = factoryManager.makeDateFormatterManager()
        guard let dateFormatterManager = dateFormatterManager else { return }
        dateLabel.text = dateFormatterManager.refactorDate(date: model.week[0].date)
    }
}
