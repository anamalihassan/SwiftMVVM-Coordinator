//
//  PaymentMethodsTableViewCell.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 28/04/2021.
//

import UIKit

class PaymentMethodsTableViewCell: AppTableViewCell {
    
    // MARK: - Properties
    
    let logoImageView:CacheImageView = {
        let img = CacheImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = AppColor.appPrimary.color
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.header)
        label.textColor = AppColor.textGray.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - UI Setup
    
    override func prepareView() {
        self.contentView.addSubview(logoImageView)
        self.contentView.addSubview(titleLabel)
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    // MARK: - Setup Layout
    
    override func setConstraintsView() {
        NSLayoutConstraint.activate([
            logoImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:16),
            titleLabel.topAnchor.constraint(equalTo:self.contentView.topAnchor, constant:16),
            titleLabel.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor, constant:-16),
            logoImageView.widthAnchor.constraint(equalToConstant:60),
            logoImageView.heightAnchor.constraint(equalToConstant:30),
//            titleLabel.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo:self.logoImageView.trailingAnchor, constant:16),
            titleLabel.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-16),
        ])
    }

}

extension PaymentMethodsTableViewCell {
    
    func configureCell(data: ApplicableNetwork?) {
        self.titleLabel.text = data?.label
        
        if let logo = data?.links?["logo"]{
            logoImageView.downloadImageFrom(url: logo.absoluteString, imageMode: .scaleAspectFit)
        }
    }
}
