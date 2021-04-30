//
//  MockAPIService.swift
//  SwiftMVVMTests
//
//  Created by Ali Hassan on 29/04/2021.
//

import Foundation

@testable import SwiftMVVM

class MockAPIService: APIService {
    func getPaymentMethods(completion: @escaping PaymentMethodsCompletionHandler) {
        isGetPaymentMethodsCalled = true
        let paymentMethods = StubGenerator().stubPaymentMethodsList()
        completion(paymentMethods, nil)
    }
    
    var isGetPaymentMethodsCalled = false
    
}

class StubGenerator {
    func stubPaymentMethodsList() -> PaymentMethodsListResult {
        let path = Bundle(for: type(of: self)).path(forResource: "PaymentMethodsListResult", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let result = try! decoder.decode(PaymentMethodsListResult.self, from: data)
        return result
    }
}

