//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 23.12.2023.
//

import Foundation

final class OAuth2Service {
    
    private var lastCode: String?
    private var currentTask: URLSessionTask?
    
    func fetchAuthToken(
        _ code: String,
        completion: @escaping (Result<String, Error>) -> Void
    ) {
        assert(Thread.isMainThread)
        if lastCode == code { return }
        currentTask?.cancel()
        lastCode = code
        
        let request = makeRequest(code)
        let task = URLSession.shared.objectTask(for: request) { [weak self] (result: Result<OAuthTokenResponseBody, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    completion(.success(response.accessToken))
                case .failure(let error):
                    completion(.failure(error))
                    self.lastCode = nil
                }
                self.currentTask = nil
            }
        }
        currentTask = task
        task.resume()
    }
    
    private func makeRequest(_ code: String) -> URLRequest {
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token")!
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: ApiConstants.accessKey),
            URLQueryItem(name: "client_secret", value: ApiConstants.secretKey),
            URLQueryItem(name: "redirect_uri", value: ApiConstants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        let url = urlComponents.url!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        return request
    }
}
