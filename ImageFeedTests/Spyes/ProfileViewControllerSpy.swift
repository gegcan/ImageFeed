//
//  ProfileViewControllerSpy.swift
//  ImageFeedTests
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation
import ImageFeed
import UIKit.UILabel

final class ProfileViewControllerSpy: ProfileViewControllerProtocol {
    var presenter: ImageFeed.ProfilePresenterProtocol?
    
    var viewDidUpdateAvatar = false
    var viewDidLoadProfile = false
    
    var profileFullNameLabel = UILabel()
    var profileLoginNameLabel = UILabel()
    var profileBioLabel = UILabel()
    
    func updateAvatar(url: URL) {
        viewDidUpdateAvatar = true
    }
    
    func loadProfile(_ profile: ImageFeed.Profile?) {
        viewDidLoadProfile = true
        if let profile {
            profileFullNameLabel.text = profile.name
            profileLoginNameLabel.text = profile.loginName
            profileBioLabel.text = profile.bio
        }
    }
}
