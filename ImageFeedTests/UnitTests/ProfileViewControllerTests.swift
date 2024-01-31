//
//  ProfileViewControllerTests.swift
//  ImageFeedTests
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

@testable import ImageFeed
import XCTest

final class ProfileViewControllerTests: XCTestCase {
    
    let viewController = ProfileViewControllerSpy()
    let presenter = ProfilePresenter()
    
    override func setUpWithError() throws {
        viewController.presenter = presenter
        presenter.view = viewController
    }
    
    func testPresenterCallsLoadProfile() {
        // given
        let testUser = "test"
        let testProfile = Profile(username: testUser, name: testUser, loginName: testUser, bio: testUser)
        
        // when
        viewController.loadProfile(testProfile)
        
        // then
        XCTAssertTrue(viewController.viewDidLoadProfile)
        XCTAssertEqual(viewController.profileBioLabel.text, testUser)
        XCTAssertEqual(viewController.profileFullNameLabel.text, testUser)
        XCTAssertEqual(viewController.profileLoginNameLabel.text, testUser)
    }
    
    func testPresenterCallsUpdateAvatar() {
        // given
        let testUrl = URL(string: "https://apple.com")!
        
        // when
        viewController.updateAvatar(url: testUrl)
        
        // then
        XCTAssertTrue(viewController.viewDidUpdateAvatar)
    }
}
