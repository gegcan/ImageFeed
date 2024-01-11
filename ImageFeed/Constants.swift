//
//  Constants.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 15.12.2023.
//

import UIKit

enum ApiConstants: String {
    case AccessKey = "DZIp8v9L5885uHlDWzJEZJxeMyMECgVCYh9SBBxtfq0"
    case SecretKey = "ktshwGtS-nwuVStFeUoUtA48DFuXOHUxbhf9QGol-OM"
    case RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
    case AccessScope = "public+read_user+write_likes"
}

//let AccessKey = "DZIp8v9L5885uHlDWzJEZJxeMyMECgVCYh9SBBxtfq0"
//let SecretKey = "ktshwGtS-nwuVStFeUoUtA48DFuXOHUxbhf9QGol-OM"
//let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
//let AccessScope = "public+read_user+write_likes"
let DefaultBaseURL = URL(string: "https://api.unsplash.com")!
