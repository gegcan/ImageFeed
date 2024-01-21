//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 21.01.2024.
//

import Foundation

struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
    
    enum CodingKeys: String, CodingKey {
        case username
        case firstName = "first_name"
        case lastName = "last_name"
        case bio
    }
}
