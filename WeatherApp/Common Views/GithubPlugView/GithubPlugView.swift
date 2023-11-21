//
//  GithubPlugView.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 20.11.2023.
//

import UIKit
import SnapKit

protocol GithubPlugViewDelegate: AnyObject {
    func tapOnSelf()
}

protocol GithubPlugViewProtocol: UIView {
    var delegate: GithubPlugViewDelegate? { get set }
}

class GithubPlugView: UIView {

    weak var delegate: GithubPlugViewDelegate?

    private(set) lazy var invertocatImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "github-mark")
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.isUserInteractionEnabled = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = ApplicationSharedTypes.weatherAppRepository.rawValue
        return label
    }()

    required init() {
        super.init(frame: .zero)
        setupUI()
        setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GithubPlugView: GithubPlugViewProtocol {

}

private extension GithubPlugView {
    func setupUI() {
        setupImageView()
        setupTitleLabel()
    }

    func setupImageView() {
        self.addSubview(invertocatImageView)
        invertocatImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(150.0)
        }
    }

    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50.0)
            make.top.equalTo(invertocatImageView.snp.bottom).offset(10.0)
            make.bottom.equalToSuperview()
        }
    }

    func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapOnViewSelf))
        self.addGestureRecognizer(tap)
    }

    @objc func tapOnViewSelf() {
        delegate?.tapOnSelf()
    }
}
