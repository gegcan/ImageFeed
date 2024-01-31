//
//  Notification+Extension.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation

extension Notification {
    
    static let userInfoImageURLKey: String = "URL"
    
    var userInfoImageURL: String? {
        userInfo?[Notification.userInfoImageURLKey] as? String
    }
}
