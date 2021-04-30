//
//  PaymentMethodsTableDataSource.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//


import UIKit

class PaymentMethodsTableDataSource: NSObject {
    typealias PaymentMethodsSelectionHandler = (ApplicableNetwork) -> ()
    
    private var paymentMethods: [ApplicableNetwork] = []
    private var didSelectItemHandler: PaymentMethodsSelectionHandler?
    
    init(with paymentMethods: [ApplicableNetwork] = [], didSelectItemHandler: @escaping PaymentMethodsSelectionHandler) {
        self.paymentMethods = paymentMethods
        self.didSelectItemHandler = didSelectItemHandler
    }
    
    func setPaymentMethodsData(_ paymentMethods: [ApplicableNetwork]) {
        self.paymentMethods = paymentMethods
    }
}

// MARK: - Table View Data Source

extension PaymentMethodsTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paymentMethods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentMethodsTableViewCell.identifier, for: indexPath) as! PaymentMethodsTableViewCell
        cell.accessibilityIdentifier = "paymentMethodCell_\(indexPath.row)"
        cell.configureCell(data: paymentMethods[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Table View Delegate

extension PaymentMethodsTableDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let paymentMethod = paymentMethods[indexPath.row]
        didSelectItemHandler?(paymentMethod)
    }
}
