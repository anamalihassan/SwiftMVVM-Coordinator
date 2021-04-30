//
//  PaymentMethodsViewModel.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//

import Foundation

protocol APIService {
    typealias PaymentMethodsCompletionHandler = (PaymentMethodsListResult?, String?) -> Void
    
    
    func getPaymentMethods(completion: @escaping PaymentMethodsCompletionHandler)
    
}

struct APIServiceImpl:APIService {
    static let environment : NetworkEnvironment = .production
    let router = Router<PaymentAPI>()
    
    func getPaymentMethods(completion: @escaping APIService.PaymentMethodsCompletionHandler) {
        
        router.request(.paymenMethods) { data, response, error in
            
            if error != nil {
                completion(nil, NetworkResponse.networkConnectionError.rawValue)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        print(responseData)
                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(PaymentMethodsListResult.self, from: responseData)
                        completion(apiResponse,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case networkConnectionError = "Please check your network connection."
}

enum Result<String>{
    case success
    case failure(String)
}
