//
//  Constants.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 15.12.2023.
//

import Foundation

enum Constants {
    
    // MARK: - Unsplash API standart constants for app
    static let accessKey = "DZIp8v9L5885uHlDWzJEZJxeMyMECgVCYh9SBBxtfq0"
    static let secureKey = "ktshwGtS-nwuVStFeUoUtA48DFuXOHUxbhf9QGol-OM"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    
    // MARK: - Unsplash base URLs
    static let defaultApiBaseURLString = "https://api.unsplash.com"
    static let baseURLString = "https://unsplash.com"
    static let authorizeURLString = "https://unsplash.com/oauth/authorize"
    
    // MARK: - Unsplash base AIP paths
    static let authorizedURLPath = "/oauth/authorize/native"
    static let tokenRequestPathString = "/oauth/token"
    static let profileRequestPathString = "/me"
    
    // MARK: - Request method's strings
    static let postMethodString = "POST"
    static let getMethodString = "GET"
    static let deleteMethodString = "DELETE"
    
    // MARK: - Storage constants
    static let tokenRequestGrantTypeString = "authorization_code"
    static let code = "code"
    static let bearerToken = "bearerToken"
    
    // MARK: - Default date formatter
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM YYYY"
        return dateFormatter
    }()
    
    // MARK: - Scale width to share
    static let scaledWidth = 768.0
}
