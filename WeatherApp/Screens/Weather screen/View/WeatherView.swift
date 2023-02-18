//
//  WeatherView.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 17.02.2023.
//

import UIKit
import SnapKit

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

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionViewLayout().createCollectionViewLayout(leading: 20, trailing: 20, height: 200, width: UIScreen.main.bounds.width/3, spacing: 8))
        collectionView.register(SmallerWeatherCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SmallerWeatherCollectionViewCell.self))
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView

    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
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

        // collection
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(blueRectangleView.snp.bottom).offset(20)
            make.height.equalTo(200)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(40)
        }
    }

    func setData(model: WeatherModel) {
        self.model = model
        localLabel.text = "\(model.province.uppercased()), \n\(model.country)"

        dateFormatterManager = factoryManager.makeDateFormatterManager()
        guard let dateFormatterManager = dateFormatterManager else { return }
        dateLabel.text = dateFormatterManager.refactorDate(date: model.week[0].date)

        tempLabel.text = "\(model.week[0].temp_avg) °C"
    }
}

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = model else { return 1 }
        return model.week.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SmallerWeatherCollectionViewCell.self), for: indexPath) as? SmallerWeatherCollectionViewCell
        guard let cell = cell,
              let model = model else { return UICollectionViewCell() }
        cell.setData(model: model.week[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let model = model else { return }
    }

}
