//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
    var secondButtonText: String? = nil
    var secondCompletion: (() -> Void)? = {}
}
