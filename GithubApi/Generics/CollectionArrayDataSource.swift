//
//  CollectionArrayDataSource.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 12/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import UIKit

class CollectionArrayDataSource<T, Cell: UICollectionViewCell>: CollectionDataSource<ArrayDataProvider<T>, Cell>
    where Cell: ConfigurableCell, Cell.T == T
{
    // MARK: - Lifecycle
    convenience init(collectionView: UICollectionView, array: [T]) {
        self.init(collectionView: collectionView, array: [array])
    }

    init(collectionView: UICollectionView, array: [[T]]) {
        let provider = ArrayDataProvider(array: array)
        super.init(collectionView: collectionView, provider: provider)
    }

    // MARK: - Public Methods
    func item(at indexPath: IndexPath) -> T? {
        return provider.item(at: indexPath)
    }

    func updateItem(at indexPath: IndexPath, value: T) {
        provider.updateItem(at: indexPath, value: value)
    }

    func appendItems(array: [T]) {
        provider.appendItems(array: [array])
    }
}
