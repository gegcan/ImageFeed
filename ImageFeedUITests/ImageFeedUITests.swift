//
//  ImageFeedUITests.swift
//  ImageFeedUITests
//
//  Created by Александр Гегешидзе on 31.01.2024.
//

import XCTest

final class ImageFeedUITests: XCTestCase {
    private let app = XCUIApplication()
    
    enum TestCredentials {
        static let email = "Your email"
        static let password = "Your password"
        static let name = "Your Full Name in Unsplash"
        static let login = "Your Unsplash login (start with @)"
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func testAuth() throws {
        app.buttons["Authenticate"].tap()
        
        let webView = app.webViews["UnsplashWebView"]
        
        XCTAssertTrue(webView.waitForExistence(timeout: 5))
        
        let passwordTextField = webView.descendants(matching: .secureTextField).element
        XCTAssertTrue(passwordTextField.waitForExistence(timeout: 5))
        
        passwordTextField.tap()
        passwordTextField.typeText(TestCredentials.password)
        webView.swipeUp()
        
        let loginTextField = webView.descendants(matching: .textField).element
        XCTAssertTrue(loginTextField.waitForExistence(timeout: 5))
        
        loginTextField.tap()
        loginTextField.typeText(TestCredentials.email)
        webView.swipeUp()
        
        
        
        webView.buttons["Login"].tap()
        
        let tablesQuery = app.tables
        let cell = tablesQuery.children(matching: .cell).element(boundBy: 0)
        
        XCTAssertTrue(cell.waitForExistence(timeout: 5))
    }
    
    func testFeed() throws {
        XCTAssertTrue(app.tabBars.buttons.element(boundBy: 0).waitForExistence(timeout: 3))
        
        let tableQuery = app.tables
        print("passed tableQuery")
        let cell = tableQuery.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 3))
        
        cell.swipeDown()
        sleep(2)
        cell.swipeUp()
        sleep(2)
        
        let cellFirst = tableQuery.children(matching: .cell).element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 3))
        XCTAssertTrue(cell.buttons["LikeButton"].waitForExistence(timeout: 1))
        cellFirst.buttons["LikeButton"].tap()
        sleep(3)
        cellFirst.buttons["LikeButton"].tap()
        sleep(3)
        
        cellFirst.tap()
        let image = app.scrollViews.images.element(boundBy: 0)
        image.pinch(withScale: 3, velocity: 1)
        image.pinch(withScale: 0.5, velocity: -1)
        
        XCTAssertTrue(app.buttons["BackButton"].waitForExistence(timeout: 3))
        app.buttons["BackButton"].tap()
    }
    
    func testProfile() throws {
        XCTAssertTrue(app.tabBars.buttons.element(boundBy: 1).waitForExistence(timeout: 3))
        app.tabBars.buttons.element(boundBy: 1).tap()
        
        XCTAssertTrue(app.buttons["ExitButton"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.staticTexts[TestCredentials.name].exists)
        XCTAssertTrue(app.staticTexts[TestCredentials.login].exists)
        
        app.buttons["ExitButton"].tap()
        
        XCTAssertTrue(app.alerts["Alert"].waitForExistence(timeout: 3))
        app.alerts["Alert"].buttons["Да"].tap()
        
        XCTAssertTrue(app.buttons["Authenticate"].waitForExistence(timeout: 3))
    }
}
