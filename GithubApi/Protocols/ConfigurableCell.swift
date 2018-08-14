//
//  ConfigurableCell.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 12/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

protocol ConfigurableCell: ReusableCell {
    associatedtype T

    func configure(_ item: T, at indexPath: IndexPath)
}
