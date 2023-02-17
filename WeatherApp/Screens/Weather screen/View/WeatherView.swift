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

    private var model: WeatherModel?

    private(set) lazy var localLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()

    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FullDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: FullDetailsTableViewCell.self))
        tableView.register(ShortDetailsTableViewCell.self, forCellReuseIdentifier: String(describing: ShortDetailsTableViewCell.self))
        tableView.separatorStyle = .none
        tableView.backgroundColor = .red
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.backgroundColor = .white

        // localLabel
        self.addSubview(localLabel)
        localLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(70)
            make.leading.equalToSuperview().inset(20)
        }
        localLabel.layoutIfNeeded()

        // tableView
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(localLabel.snp.bottom)
        }
    }

    func setData(model: WeatherModel) {
        self.model = model
        localLabel.text = "\(model.province.uppercased()), \n\(model.country)"

    }

}

extension WeatherView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let fullCell = tableView.dequeueReusableCell(withIdentifier: String(describing: FullDetailsTableViewCell.self), for: indexPath) as? FullDetailsTableViewCell
            guard let fullCell = fullCell else { return UITableViewCell()}
            return fullCell
        } else {
            let shortCell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShortDetailsTableViewCell.self), for: indexPath) as? ShortDetailsTableViewCell
            guard let shortCell = shortCell else { return UITableViewCell()}
            return shortCell
        }
    }


}
