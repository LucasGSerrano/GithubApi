//
//  NetworkService.swift
//  GithubApi
//
//  Created by Lucas Gonçalves Serrano on 13/08/18.
//  Copyright © 2018 Lucas Gonçalves Serrano. All rights reserved.
//

import Foundation
import Alamofire

final class NetworkService {
    let baseURL: String

    init(withBaseURL baseURL: String) {
        self.baseURL = baseURL
    }

    func fetch<Model: Codable> (fromRoute route: Route<Model>, _ paging: Int?,
                                then: @escaping (Result<Model>) -> Void) {

        // make sure the endpoint path is a valid URL

        var endpoint = route.endpoint
        if let pag = paging { endpoint += String(pag) }

        guard let url = URL(string: self.baseURL + endpoint ) else {
            then(.failure(NSError(domain: "warpfactor.io", code: 500)))
            return
        }

        Alamofire
            .request(url)
            .responseData { (response) in
                guard response.error == nil else {
                    then(.failure(response.error!))
                    return
                }

                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601

                if let data = response.data,
                    let model = try? jsonDecoder.decode(Model.self, from: data) {
                    then(.success(model))
                } else {
                    then(.failure(NSError(  domain: "warpfactor.io",
                                            code: 1000,
                                            userInfo: ["error":"wrong model"])))
                }
        }
    }
}
