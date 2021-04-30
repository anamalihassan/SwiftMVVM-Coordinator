//
//  PaymentMethodsViewModelTests.swift
//  SwiftMVVMTests
//
//  Created by Ali Hassan on 29/04/2021.
//

import XCTest
@testable import SwiftMVVM

class PaymentMethodsViewModelTests: XCTestCase {
    
    var sut: PaymentMethodsViewModel!
    var mockAPIService: MockAPIService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = MockAPIService()
        sut = PaymentMethodsViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_payment_methods() {
        sut.getPaymentMethods()
    
        // Assert
        XCTAssert(mockAPIService!.isGetPaymentMethodsCalled)
    }
    
    func test_payment_methods_cells() {

        let paymentMethods = StubGenerator().stubPaymentMethodsList()
        
        let expect = XCTestExpectation(description: "payment methods count")
        sut.didFinishFetch = { () in
            expect.fulfill()
        }
        
        sut.getPaymentMethods()
        
        // paymentMethods count is equal to the number of payment Methods data
        XCTAssertEqual( sut.paymentMethods.count, paymentMethods.networks.applicable.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}
