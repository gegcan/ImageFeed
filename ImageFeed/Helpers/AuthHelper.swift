//
//  AuthHelper.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation

protocol AuthHelperProtocol {
    func authRequest() -> URLRequest
    func code(from url: URL) -> String?
}

final class AuthHelper {
    let configuration: AuthConfiguration
    
    init(configuration: AuthConfiguration = .standard) {
        self.configuration = configuration
    }
}

private extension AuthHelper {
    enum WebElements {
        static let clientId = "client_id"
        static let redirectUri = "redirect_uri"
        static let responseType = "response_type"
        static let scope = "scope"
    }
}

extension AuthHelper {
    func authURL() -> URL {
        guard var urlComponents = URLComponents(string: configuration.authURLString) else {
            preconditionFailure("AH 52 Incorrect string: \(configuration.authURLString)")
        }
        urlComponents.queryItems = [
            URLQueryItem(name: WebElements.clientId, value: configuration.accessKey),
            URLQueryItem(name: WebElements.redirectUri, value: configuration.redirectURI),
            URLQueryItem(name: WebElements.responseType, value: Constants.code),
            URLQueryItem(name: WebElements.scope, value: configuration.accessScope)
        ]
        guard let url = urlComponents.url else {
            preconditionFailure("AH 61 Incorrect URL: \(String(describing: urlComponents.url))")
        }
        return url
    }
}

extension AuthHelper: AuthHelperProtocol {
    func authRequest() -> URLRequest {
        URLRequest(url: authURL())
    }
    
    func code(from url: URL) -> String? {
        if
            let urlComponents = URLComponents(string: url.absoluteString),
            urlComponents.path == Constants.authorizedURLPath,
            let items = urlComponents.queryItems,
            let codeItem = items.first(where: { $0.name == Constants.code }) {
            return codeItem.value
        } else {
            return nil
        }
    }
}
