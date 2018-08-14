//
//  Result.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 13/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

enum Result<Model> {
    case success(Model)
    case failure(Error)
}
