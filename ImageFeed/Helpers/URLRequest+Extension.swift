//
//  URLRequestExtension.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 14.01.2024.
//

import Foundation

final class URLRequestBuilder {
    
    static let shared = URLRequestBuilder()
    private let storage = OAuth2TokenStorage.shared
    
    func makeHTTPRequest(path: String, httpMethod: String? = nil, baseURLString: String? = nil) -> URLRequest? {
        
        guard
            let url = URL(string: baseURLString ?? AuthConfiguration.standard.apiURLString),
            let baseURL = URL(string: path, relativeTo: url)
        else { return nil }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = httpMethod ?? Constants.getMethodString
        
        if let token = storage.token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
