//
//  PaymentMethodsViewModel.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//

import Foundation


enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum PaymentAPI {
    case paymenMethods
}

extension PaymentAPI: EndPointType {
    
    var environmentBaseURL : String {
        switch APIServiceImpl.environment {
        case .production: return "https://raw.githubusercontent.com/"
        case .qa: return "https://raw.githubusercontent.com/"
        case .staging: return "https://raw.githubusercontent.com/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .paymenMethods:
            return "optile/checkout-android/develop/shared-test/lists/listresult.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        return .request
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}


