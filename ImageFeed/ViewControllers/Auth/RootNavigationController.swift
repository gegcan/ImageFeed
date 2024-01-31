//
//  RootNavigationController.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import UIKit

final class RootNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}
