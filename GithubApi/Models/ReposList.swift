//
//  Repos.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 13/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct ReposList: Codable {
    let items: [Repos]?
}

struct Repos: Codable {
    let id: Int
    let name: String?
    let description: String?
    let forks: Int?
    let stars: Int?

    let owner: Owner?

    private enum CodingKeys: String, CodingKey {
        case id, name, description, owner
        case forks = "forks_count"
        case stars = "stargazers_count"
    }
}

struct Owner: Codable {
    let name: String?
    let imageUrl: String?

    private enum CodingKeys: String, CodingKey {
        case name = "login"
        case imageUrl = "avatar_url"
    }
}
