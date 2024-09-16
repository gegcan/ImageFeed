//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 23.12.2023.
//

import UIKit

final class SplashViewController: UIViewController {
    private lazy var unsplashLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let oAuth2Service = OAuth2Service.shared
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imageListService = ImageListService.shared
    
    private var alertPresenter: AlertPresenting?
    private var wasChecked = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(viewController: self)
        setupSplashViewController()
        UIBlockingProgressHUD.setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        checkAuthStatus()
    }
}

private extension SplashViewController {
    
    func checkAuthStatus() {
        guard !wasChecked else { return }
        wasChecked = true
        if oAuth2Service.isAuthenticated {
            UIBlockingProgressHUD.show()
            
            fetchProfile { [weak self] in
                UIBlockingProgressHUD.dismiss()
                self?.switchToTabBarController()
            }
        } else {
            showAuthViewController()
        }
    }
    
    func showLoginAlert(error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alertModel = AlertModel(
                title: "Что-то пошло не так :(",
                message: "Не удалось войти в систему: \(error.localizedDescription)",
                buttonText: "Ok") {
                    self.wasChecked = false
                    guard OAuth2TokenStorage.shared.removeToken() else {
                        assertionFailure("Cannot remove token")
                        return
                    }
                    self.checkAuthStatus()
                }
            self.alertPresenter?.showAlert(for: alertModel)
        }
    }
}

private extension SplashViewController {
    
    func showAuthViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AuthViewController")
        guard let viewController = viewController as? AuthViewController else { return }
        viewController.delegate = self
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: false)
    }
    
    func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else { preconditionFailure("Invalid Configuration") }
        let tabBarController = TabBarController()
        window.rootViewController = tabBarController
    }
    
    func setupSplashViewController() {
        view.backgroundColor = .ypBackground
        view.addSubview(unsplashLogoImage)
        
        NSLayoutConstraint.activate([
            unsplashLogoImage.widthAnchor.constraint(equalToConstant: 75),
            unsplashLogoImage.heightAnchor.constraint(equalToConstant: 77),
            unsplashLogoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            unsplashLogoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }
}

private extension SplashViewController {
    
    func fetchAuthToken(with code: String) {
        UIBlockingProgressHUD.show()
        oAuth2Service.fetchAuthToken(with: code) { [weak self] authResult in
            guard let self else { preconditionFailure("Cannot fetch auth token") }
            switch authResult {
            case .success:
                self.fetchProfile(completion: {
                    UIBlockingProgressHUD.dismiss()
                })
            case .failure(let error):
                self.showLoginAlert(error: error)
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func fetchProfile(completion: @escaping () -> Void) {
        profileService.fetchProfile { [weak self] profileResult in
            guard let self else { preconditionFailure("Cannot fetch profileResult") }
            switch profileResult {
            case .success(let profile):
                let userName = profile.username
                self.fetchProfileImage(userName: userName)
            case .failure(let error):
                self.showLoginAlert(error: error)
            }
            completion()
        }
    }
    
    func fetchProfileImage(userName: String) {
        profileImageService.fetchProfileImageURL(userName: userName) { [weak self] profileImageUrl in
            guard let self else { return }
            switch profileImageUrl {
            case .success:
                self.switchToTabBarController()
            case .failure(let error):
                self.showLoginAlert(error: error)
            }
        }
    }
}

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ viewController: AuthViewController, didAuthenticateWithCode code: String) {
        dismiss(animated: true) {
            [weak self] in
            guard let self else { return }
            self.fetchAuthToken(with: code)
        }
    }
}
