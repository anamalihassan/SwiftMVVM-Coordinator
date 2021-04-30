//
//  AppCoordinator.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//


import UIKit

class AppCoordinator: AppCoordinatorProtocol {
    
    var rootViewController: UINavigationController!
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else { return }
        
        rootViewController = UINavigationController(rootViewController: getPaymentMethodsViewController())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func getPaymentMethodsViewController() -> PaymentMethodsViewController {
        let viewModel = PaymentMethodsViewModel()
        let viewController = PaymentMethodsViewController(viewModel: viewModel)
//        viewController.delegate = self
        return viewController
    }
}
