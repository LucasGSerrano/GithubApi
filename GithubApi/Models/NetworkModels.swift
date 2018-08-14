//
//  NetworkModels.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 13/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct Route<Model> {
    let endpoint: String
}

struct Routes {
    static let repos = Route<ReposList>(endpoint: "search/repositories?q=language:Swift&sort=stars&page=")
}
