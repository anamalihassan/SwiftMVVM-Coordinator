//
//  PaymentMethodsViewControllerTests.swift
//  SwiftMVVMTests
//
//  Created by Ali Hassan on 29/04/2021.
//


import XCTest
@testable import SwiftMVVM

class PaymentMethodsViewControllerTests: XCTestCase {
    
    
    let paymentMethods = StubGenerator().stubPaymentMethodsList().networks.applicable
    
    func test_viewDidLoad_rendersHeaderTitle() {
        XCTAssertEqual(makeSUT().navigationItem.title, Constants.App.PAYMENT_METHODS_MSG)
    }
    
    func test_viewDidLoad_configuresPaymentMethodsTV() {
        XCTAssertNotNil(makeSUT().paymentMethodsTV)
    }
    
    func test_paymentMethodsTV_rendersWithoutPaymentMethods() {
        let sut = makeSUT()
        XCTAssertEqual(sut.paymentMethodsTV.numberOfRows(inSection: 0), sut.viewModel.paymentMethods.count)
    }
    
    func test_paymentMethodsTV_rendersPaymentMethods() {
        XCTAssertEqual(makeSUT(paymentMethods).paymentMethodsTV.numberOfItems(), paymentMethods.count)
    }
    
    func test_paymentMethodsTV_rendersCellForPaymentMethodsTV() {
        XCTAssertEqual(makeSUT(paymentMethods).paymentMethodsTV.title(at: 0), paymentMethods[0].label)
        XCTAssertEqual(makeSUT(paymentMethods).paymentMethodsTV.title(at: 1), paymentMethods[1].label)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(_ paymentMethods: [ApplicableNetwork] = []) -> PaymentMethodsViewController {
        let apiService = MockAPIService()
        let viewModel = PaymentMethodsViewModel(apiService: apiService)
        viewModel.getPaymentMethods()
        
        let sut = PaymentMethodsViewController(viewModel: viewModel)
        _ = sut.view
        sut.reloadData()
        return sut
    }
}

private extension UITableView {
    func numberOfItems() -> Int {
        return numberOfRows(inSection: 0)
    }
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(item: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let paymentMethodCell = cell(at: row) as! PaymentMethodsTableViewCell
        return paymentMethodCell.titleLabel.text
    }
}
