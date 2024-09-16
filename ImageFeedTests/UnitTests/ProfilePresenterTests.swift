//
//  ProfilePresenterTests.swift
//  ImageFeedTests
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

@testable import ImageFeed
import XCTest

final class ProfilePresenterTests: XCTestCase {
    
    let viewController = ProfileViewController()
    let presenter = ProfilePresenterSpy()
    
    override func setUpWithError() throws {
        // given
        viewController.presenter = presenter
        presenter.view = viewController
    }
    
    func testViewControllerCallViewDidLoad() {
        // when
        _ = viewController.view
        
        // then
        XCTAssertTrue(presenter.viewDidLoadCalled)
    }
    
    func testViewControllerCallResetAccount() {
        // when
        _ = viewController.view
        presenter.resetAccount()
        
        // then
        XCTAssertTrue(presenter.viewDidResetAccount)
    }
}
