//
//  PaymentMethodsTableViewCellTests.swift
//  SwiftMVVMTests
//
//  Created by Ali Hassan on 29/04/2021.
//

import XCTest
@testable import SwiftMVVM

class PaymentMethodsTableViewCellTests: XCTestCase {
    
    func test_setup_rendersCorrectData() {
        let sut = makeSUT()
        let paymentMethodsList = StubGenerator().stubPaymentMethodsList()
        let paymentMethod = paymentMethodsList.networks.applicable[0]
        sut.configureCell(data: paymentMethod)
        
        XCTAssertNotNil(sut.logoImageView)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertEqual(sut.titleLabel.text, paymentMethod.label)
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> PaymentMethodsTableViewCell {
        let cell = PaymentMethodsTableViewCell()
        return cell
    }
    
}
