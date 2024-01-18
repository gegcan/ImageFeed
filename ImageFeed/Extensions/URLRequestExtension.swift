//
//  URLRequestExtension.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 14.01.2024.
//

import Foundation

// MARK: - HTTP Request
let urlDefault = URL(string: ApiConstants.defaultBaseURL)!

extension URLRequest {
    static func makeHTTPRequest(
        path: String,
        httpMethod: String,
        baseURL: URL = urlDefault
    ) -> URLRequest {
        var request = URLRequest(url: URL(string: path, relativeTo: baseURL) ?? urlDefault)
        request.httpMethod = httpMethod
        return request
    }
}
