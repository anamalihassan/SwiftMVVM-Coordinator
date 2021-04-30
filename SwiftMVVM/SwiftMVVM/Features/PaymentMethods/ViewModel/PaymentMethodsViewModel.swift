//
//  PaymentMethodsViewModel.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//

import Foundation

class PaymentMethodsViewModel {
    
    // MARK: - Properties
    var paymentMethods: [ApplicableNetwork] = [] {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var error: String? {
        didSet { self.showAlert?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    private let apiService: APIService
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init( apiService: APIService = APIServiceImpl()) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func getPaymentMethods() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.apiService.getPaymentMethods(completion: { (response, error) in
            self.isLoading = false
            if let errorMessage = error{
                self.error = errorMessage
            }else {
                self.paymentMethods = response?.networks.applicable ?? []
            }
        })
    }
}
