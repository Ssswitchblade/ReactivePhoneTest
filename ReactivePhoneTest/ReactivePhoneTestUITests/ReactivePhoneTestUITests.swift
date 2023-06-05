//
//  ReactivePhoneTestUITests.swift
//  ReactivePhoneTestUITests
//
//  Created by Admin on 05.06.2023.
//

import XCTest
@testable import ReactivePhoneTest

final class ReactivePhoneTestUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        app.textFields[ImageGeneratorVCAIDs.textField].tap()
        app.textFields[ImageGeneratorVCAIDs.textField].firstMatch.typeText("Apple")
        let image = app.images[ImageGeneratorVCAIDs.imageView]
        image.tap()
        app.buttons[ImageGeneratorVCAIDs.addTovFavoriteButton].tap()
        
        XCTAssertTrue(image.waitForExistence(timeout: 10))
        
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
