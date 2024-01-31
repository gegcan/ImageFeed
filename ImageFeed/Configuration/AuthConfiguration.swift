//
//  AuthConfiguration.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation

struct AuthConfiguration {
  let accessKey: String
  let secretKey: String
  let redirectURI: String
  let accessScope: String
  let apiURLString: String
  let authURLString: String
  let baseURLString: String

  static var standard: AuthConfiguration {
    AuthConfiguration(
      accessKey: Constants.accessKey,
      secretKey: Constants.secureKey,
      redirectURI: Constants.redirectURI,
      accessScope: Constants.accessScope,
      apiURLString: Constants.defaultApiBaseURLString,
      authURLString: Constants.authorizeURLString,
      baseURLString: Constants.baseURLString)
  }
}
