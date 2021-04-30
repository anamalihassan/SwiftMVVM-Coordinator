//
//  PaymentMethodsViewController.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//

import UIKit

class PaymentMethodsViewController: AppViewController {
    
    // MARK: Properties
    
    let viewModel: PaymentMethodsViewModel
    
    
    lazy var paymentMethodsTV: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PaymentMethodsTableViewCell.self, forCellReuseIdentifier: PaymentMethodsTableViewCell.identifier)
        tableView.accessibilityIdentifier = "paymentMethodsTV"
        tableView.tableFooterView = UIView()
        tableView.layer.masksToBounds = true
        tableView.layer.borderColor = AppColor.lineGray.color.cgColor
        tableView.layer.borderWidth = 1.0
        return tableView
    }()
    
    private var dataSource: PaymentMethodsTableDataSource?
    
    // MARK: Intitializer
    
    init(viewModel: PaymentMethodsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        setUpViewModel()
    }
    
    // MARK: set up view
    
    func setUpView(){
        self.view.backgroundColor = .white
        self.navigationItem.title = Constants.App.PAYMENT_METHODS_MSG
        self.view.addSubview(paymentMethodsTV)
        
        dataSource = PaymentMethodsTableDataSource(didSelectItemHandler: didSelectPaymentMethod())
        
        paymentMethodsTV.dataSource = dataSource
        paymentMethodsTV.delegate = dataSource
        
        NSLayoutConstraint.activate([
            paymentMethodsTV.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: 16),
            paymentMethodsTV.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            paymentMethodsTV.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            paymentMethodsTV.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
        ])
    }
    
    // MARK: set up view model
    
    private func setUpViewModel() {
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlert = {
            if let error = self.viewModel.error {
                Utils.printLog(error)
                let title = Constants.APIMessages.Warning
                let action = UIAlertAction(title: Constants.APIMessages.OK, style: .default)
                DispatchQueue.main.async {
                    Utils.displayAlert(forViewController: self, with: title , message: error, actions: [action])
                }
            }
        }
        
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
        
        self.getPaymentMethods()
    }
    
    // MARK: reload Data
    
    func reloadData() {
        dataSource?.setPaymentMethodsData(viewModel.paymentMethods)
        self.paymentMethodsTV.reloadData()
    }
    
    // MARK: - Call API
    
    private func getPaymentMethods()  {
        viewModel.getPaymentMethods()
    }
    
    //MARK: - Handle Selection
    
    private func didSelectPaymentMethod() -> PaymentMethodsTableDataSource.PaymentMethodsSelectionHandler {
        return { (paymentMethod) in
            Utils.printLog(paymentMethod.label)
        }
    }
}



