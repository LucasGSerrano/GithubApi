//
//  ArrayDataProvider.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 12/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

class ArrayDataProvider<T>: CollectionDataProvider {

    // MARK: - Internal Properties
    var items: [[T]] = []

    // MARK: - Lifecycle
    init(array: [[T]]) {
        items = array
    }

    // MARK: - CollectionDataProvider
    func numberOfSections() -> Int {
        return items.count
    }

    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }

    func item(at indexPath: IndexPath) -> T? {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else
        {
            return nil
        }
        return items[indexPath.section][indexPath.row]
    }

    func updateItem(at indexPath: IndexPath, value: T) {
        guard indexPath.section >= 0 &&
            indexPath.section < items.count &&
            indexPath.row >= 0 &&
            indexPath.row < items[indexPath.section].count else
        {
            return
        }
        items[indexPath.section][indexPath.row] = value
    }

    func appendItems(array: [[T]]) {
        items[0].append(contentsOf: array[0])
    }
}
