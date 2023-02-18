//
//  CollectionViewLayout.swift
//  WeatherApp
//
//  Created by Polina Belovodskaya on 19.02.2023.
//

import UIKit

final class CollectionViewLayout {

    public func createCollectionViewLayout(leading: CGFloat, trailing: CGFloat, height: CGFloat, width: CGFloat, spacing: CGFloat) -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            return self.createWeatherCollectionViewLayout(leading: leading, trailing: trailing, height: height, width: width, spacing: spacing)
        }
        return layout
    }
}

extension CollectionViewLayout {

    private func createWeatherCollectionViewLayout(leading: CGFloat, trailing: CGFloat, height: CGFloat, width: CGFloat, spacing: CGFloat) -> NSCollectionLayoutSection {

        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(width), heightDimension: .absolute(height))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

        let layoutSection = NSCollectionLayoutSection(group: group)
        layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: leading, bottom: 0, trailing: trailing)
        layoutSection.orthogonalScrollingBehavior = .groupPaging
        layoutSection.interGroupSpacing = spacing

        return layoutSection
    }
}