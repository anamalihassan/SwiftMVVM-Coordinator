//
//  AppCoordinatorTests.swift
//  SwiftMVVMTests
//
//  Created by Ali Hassan on 29/04/2021.
//

import XCTest

@testable import SwiftMVVM

class AppCoordinatorTests: XCTestCase {
    
    func test_coordinator_windowNil() {
        let sut = AppCoordinator(window: nil)
        
        sut.start()
        
        XCTAssertNil(sut.rootViewController)
    }
    
    func test_coordinator_makesRootViewController() {
        let sut = AppCoordinator(window: UIWindow(frame: UIScreen.main.bounds))
        sut.start()
        XCTAssertNotNil(sut.rootViewController)
    }
}
