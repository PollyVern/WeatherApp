//
//  MainCardsCollectionView.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 21.11.2023.
//

import UIKit
import SnapKit

protocol MainCardsCollectionViewDelegate: AnyObject {
    func setupData(model: WeatherModel, index: Int)
}

protocol MainCardsCollectionViewProtocol: UICollectionView {
    var mainCardsDelegate: MainCardsCollectionViewDelegate? { get set }
}

class MainCardsCollectionView: UICollectionView {

    weak var mainCardsDelegate: MainCardsCollectionViewDelegate?

    private var model: WeatherModel

    init(model: WeatherModel) {
        self.model = model
        super.init(frame: .zero, collectionViewLayout: CollectionViewLayoutManager.shared().createCollectionViewLayout(leading: 20, trailing: 20, height: 200, width: UIScreen.main.bounds.width/3, spacing: 8))
        setupTableView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MainCardsCollectionView: MainCardsCollectionViewProtocol {

}

private extension MainCardsCollectionView {
    func setupTableView() {
        register(SmallerWeatherCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: SmallerWeatherCollectionViewCell.self))
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        dataSource = self
        delegate = self
        alwaysBounceVertical = false
    }
}

extension MainCardsCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SmallerWeatherCollectionViewProtocol {
            mainCardsDelegate?.setupData(model: model, index: indexPath.row)
            cell.selectedCell()
        }
    }



    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SmallerWeatherCollectionViewProtocol else { return }
        cell.deselectedCell()
    }
}

extension MainCardsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.parts.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: SmallerWeatherCollectionViewCell.self), for: indexPath) as? SmallerWeatherCollectionViewProtocol
        guard let cell = cell else { return UICollectionViewCell() }
        cell.setData(model: model.parts[indexPath.row])
        return cell
    }
}

