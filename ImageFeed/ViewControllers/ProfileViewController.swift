//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Александр Гегешидзе on 20.11.2023.
//

import UIKit

public protocol ProfileViewControllerProtocol: AnyObject {
    var presenter: ProfilePresenterProtocol? { get set }
    func updateAvatar(url: URL)
    func loadProfile(_ profile: Profile?)
}

final  class ProfileViewController: UIViewController {
    
    private var profilePhotoImage = UIImageView()
    private var profileFullNameLabel = UILabel()
    private var profileLoginNameLabel = UILabel()
    private var profileBioLabel = UILabel()
    private var exitButton = UIButton()
    
    private var alertPresenter: AlertPresenting?
    private var profileImageServiceObserver: NSObjectProtocol?
    
    private let placeholderImage = UIImage(named: "person.crop.circle.fill")
    
    var presenter: ProfilePresenterProtocol?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        alertPresenter = AlertPresenter(viewController: self)
        presenter?.viewDidLoad()
        setupNotificationObserver()
        makeUI()
    }
}

extension ProfileViewController {
    override func becomeFirstResponder() -> Bool {
        true
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            showAlert()
        }
    }
}

private extension ProfileViewController {
    
    @objc func didTapButton() {
        showAlert()
    }
    
    @objc func updateAvatar(notification: Notification) {
        guard
            isViewLoaded,
            let userInfo = notification.userInfo,
            let profileImageURL = userInfo[Notification.userInfoImageURLKey] as? String,
            let url = URL(string: profileImageURL)
        else { return }
        updateAvatar(url: url)
    }
    
    func setupNotificationObserver() {
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] notification in
                self?.updateAvatar(notification: notification)
            }
    }
    
    func showAlert() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            let alertModel = AlertModel(
                title: "Пока, пока!",
                message: "Уверены, что хотите выйти?",
                buttonText: "Да",
                completion: { self.presenter?.resetAccount() },
                secondButtonText: "Нет",
                secondCompletion: { self.dismiss(animated: true) }
            )
            self.alertPresenter?.showAlert(for: alertModel)
        }
    }
}

private extension ProfileViewController {
    
    func makeUI() {
        makeProfilePhotoImage()
        makeProfileFullNameLabel()
        makeProfileLoginNameLabel()
        makeProfileBioLabel()
        makeProfileExitButton()
    }
    
    func makeProfilePhotoImage() {
        profilePhotoImage.layer.cornerRadius = 35
        profilePhotoImage.layer.masksToBounds = true
        profilePhotoImage.image = placeholderImage
        profilePhotoImage.accessibilityIdentifier = "ProfilePhoto"
        
        profilePhotoImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profilePhotoImage)
        
        NSLayoutConstraint.activate([
            profilePhotoImage.widthAnchor.constraint(equalToConstant: 70),
            profilePhotoImage.heightAnchor.constraint(equalToConstant: 70),
            profilePhotoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            profilePhotoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
    }
    
    func makeProfileFullNameLabel() {
        profileFullNameLabel.textColor = .ypWhite
        profileFullNameLabel.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        profileFullNameLabel.lineBreakMode = .byWordWrapping
        profileFullNameLabel.numberOfLines = 2
        profileFullNameLabel.accessibilityIdentifier = "ProfileName"
        
        profileFullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileFullNameLabel)
        
        NSLayoutConstraint.activate([
            profileFullNameLabel.topAnchor.constraint(equalTo: profilePhotoImage.bottomAnchor, constant: 8),
            profileFullNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileFullNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func makeProfileLoginNameLabel() {
        profileLoginNameLabel.textColor = .ypGray
        profileLoginNameLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        profileLoginNameLabel.accessibilityIdentifier = "ProfileLogin"
        
        profileLoginNameLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileLoginNameLabel)
        
        NSLayoutConstraint.activate([
            profileLoginNameLabel.topAnchor.constraint(equalTo: profileFullNameLabel.bottomAnchor, constant: 8),
            profileLoginNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileLoginNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func makeProfileBioLabel() {
        profileBioLabel.textColor = .ypWhite
        profileBioLabel.font = UIFont.systemFont(ofSize: 13, weight: .medium)
        profileBioLabel.lineBreakMode = .byWordWrapping
        profileBioLabel.numberOfLines = 0
        profileBioLabel.accessibilityIdentifier = "ProfileBio"
        
        profileBioLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(profileBioLabel)
        
        NSLayoutConstraint.activate([
            profileBioLabel.topAnchor.constraint(equalTo: profileLoginNameLabel.bottomAnchor, constant: 8),
            profileBioLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            profileBioLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func makeProfileExitButton() {
        let profileExitButtonImage = UIImage(named: "ipad.and.arrow.forward") ?? UIImage()
        
        exitButton = UIButton.systemButton(
            with: profileExitButtonImage,
            target: self,
            action: #selector(self.didTapButton)
        )
        exitButton.tintColor = .ypRed
        exitButton.accessibilityIdentifier = "ExitButton"
        
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(exitButton)
        
        NSLayoutConstraint.activate([
            exitButton.widthAnchor.constraint(equalToConstant: 44),
            exitButton.heightAnchor.constraint(equalToConstant: 44),
            exitButton.centerYAnchor.constraint(equalTo: profilePhotoImage.centerYAnchor),
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

extension ProfileViewController: ProfileViewControllerProtocol {
    func updateAvatar(url: URL) {
        profilePhotoImage.kf.indicatorType = .activity
        profilePhotoImage.kf.setImage(with: url, placeholder: placeholderImage)
    }
    
    func loadProfile(_ profile: Profile?) {
        if let profile {
            profileFullNameLabel.text = profile.name
            profileLoginNameLabel.text = profile.loginName
            profileBioLabel.text = profile.bio
        } else {
            profileFullNameLabel.text = ""
            profileLoginNameLabel.text = ""
            profileBioLabel.text = ""
            profilePhotoImage.image = placeholderImage
        }
    }
}
