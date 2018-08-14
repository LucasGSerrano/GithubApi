//
//  PullRequest.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 14/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation

struct PullRequests: Codable {
    let id: Int?
    let title: String?
    let body: String?
    let created: Date?
    let url: String?

    let user: Owner?

    private enum CodingKeys: String, CodingKey {
        case title, body, user, id
        case url = "html_url"
        case created = "created_at"
    }

}
