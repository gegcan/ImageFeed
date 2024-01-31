//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import Foundation
import WebKit
import Kingfisher

public protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func resetAccount()
}

final class ProfilePresenter {
    private let profileImageService = ProfileImageService.shared
    private let profileService = ProfileService.shared
    
    weak var view: ProfileViewControllerProtocol?
}

extension ProfilePresenter: ProfilePresenterProtocol {
    
    func viewDidLoad() {
        checkAvatar()
        checkProfile()
    }
    
    func resetAccount() {
        resetToken()
        resetView()
        resetImageCache()
        resetPhotos()
        resetCookies()
        switchToSplashViewController()
    }
}

private extension ProfilePresenter {
    
    func checkAvatar() {
        if let url = profileImageService.avatarURL {
            view?.updateAvatar(url: url)
        }
    }
    
    func checkProfile() {
        guard let profile = profileService.profile else {
            return
        }
        view?.loadProfile(profile)
    }
    
    func resetToken() {
        guard OAuth2TokenStorage.shared.removeToken() else {
            assertionFailure("Cannot remove token")
            return
        }
    }
    
    func resetView() {
        view?.loadProfile(nil)
    }
    
    func resetImageCache() {
        let cache = ImageCache.default
        cache.clearMemoryCache()
        cache.clearDiskCache()
    }
    
    func resetPhotos() {
        ImageListService.shared.resetPhotos()
    }
    
    func resetCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record]) { }
            }
        }
    }
    
    func switchToSplashViewController() {
        guard let window = UIApplication.shared.windows.first else { preconditionFailure("Invalid Configuration") }
        let splashViewController = SplashViewController()
        window.rootViewController = splashViewController
    }
}
