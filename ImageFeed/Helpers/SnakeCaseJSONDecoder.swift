//
//  SnakeCaseJSONDecoder.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation

class SnakeCaseJSONDecoder: JSONDecoder {
    override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
