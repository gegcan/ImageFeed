//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 23.12.2023.
//

final class OAuth2Service {
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        completion(.success(""))
    }
}
