//
//  UITableViewController+Extension.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit

extension UITableViewController {
    
    // MARK: - Property
    
    public var configureCenterIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView.grayIndicator(CGSize(width: 50, height: 50))
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        return indicator
    }
    
    public var configureFooterIndicator: UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView.grayIndicator(CGSize(width: 50, height: 50))
        self.tableView.tableFooterView = indicator
        return indicator
    }
    
    // MARK: - Public
    
    public func configureBackgroundColor() {
        self.navigationController?.view.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
    }
    
    public func hasContents() -> Bool {
        return self.tableView.contentSize.height < self.view.bounds.size.height
    }
    
}
