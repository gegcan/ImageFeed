//
//  TabBarController.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 19.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarView()
        setupTabBarViewController()
    }
}

private extension TabBarController {
    
    func setupTabBarView() {
        tabBar.barStyle = .black
        tabBar.tintColor = .ypWhite
        tabBar.backgroundColor = .ypBlack
    }
    
    func setupTabBarViewController() {
        view.backgroundColor = .ypBackground
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let imageListPresenter = ImageListPresenter()
        let imagesListViewController = storyboard.instantiateViewController(withIdentifier: "ImagesListViewController")
        guard let imagesListViewController = imagesListViewController as? ImagesListViewController else { return }
        imageListPresenter.view = imagesListViewController
        imagesListViewController.presenter = imageListPresenter
        
        let profilePresenter = ProfilePresenter()
        let profileViewController = ProfileViewController()
        profilePresenter.view = profileViewController
        profileViewController.presenter = profilePresenter
        setupTabBarItem(for: profileViewController, image: "tab_profile_active")
        
        viewControllers = [imagesListViewController, profileViewController]
        selectedIndex = 0
    }
    
    func setupTabBarItem(for viewController: UIViewController, image: String) {
        viewController.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: image),
            selectedImage: nil
        )
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        selectedViewController = viewController
    }
}
