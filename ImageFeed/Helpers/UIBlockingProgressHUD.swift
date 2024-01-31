//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 19.01.2024.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD {
    
    private static var window: UIWindow? {
        UIApplication.shared.windows.first
    }
    
    static func show() {
        window?.isUserInteractionEnabled = false
        ProgressHUD.show()
    }
    
    static func dismiss() {
        window?.isUserInteractionEnabled = true
        ProgressHUD.dismiss()
    }
    
    static func setup() {
        ProgressHUD.animationType = .circleRotateChase
        ProgressHUD.colorHUD = .clear
    }
}
