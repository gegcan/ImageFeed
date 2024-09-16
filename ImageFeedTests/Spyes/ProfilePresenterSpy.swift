//
//  ProfilePresenterSpy.swift
//  ImageFeedTests
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation
import ImageFeed

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol?
    
    var viewDidLoadCalled = false
    var viewDidResetAccount = false
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func resetAccount() {
        viewDidResetAccount = true
    }
}
