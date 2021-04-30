//
//  SwiftMVVMUITests.swift
//  SwiftMVVMUITests
//
//  Created by Ali Hassan on 28/04/2021.
//

import XCTest

class SwiftMVVMUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPaymentMethodsTV() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let paymentMethodsTV = app.tables["paymentMethodsTV"]
        XCTAssertTrue(paymentMethodsTV.exists)
        let paymentMethodCell_0 = paymentMethodsTV.cells.element(matching: .cell, identifier: "paymentMethodCell_0")
        XCTAssert(paymentMethodCell_0.waitForExistence(timeout: 10))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
