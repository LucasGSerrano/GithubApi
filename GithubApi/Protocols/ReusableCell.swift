//
//  ReusableCell.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 12/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

protocol ReusableCell {
    static var reuseIdentifier: String { get }
}

extension ReusableCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
