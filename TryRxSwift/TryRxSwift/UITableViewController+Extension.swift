//
//  UITableViewController+Extension.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/12.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import RxSwift

extension UITableViewController {
    
    // MARK: - Property
    
    public var rx_reachBottom: Observable<Void> {
        return self.tableView.rx_contentOffset
            .filter { x -> Bool in
                self.tableView.reachBottom()
            }
            .flatMap { contentOffset -> Observable<Void> in
                
                if self.tableView.contentSize.height < self.view.bounds.size.height {
                    return Observable.empty()
                }
                
                return Observable.just()
        }
    }
    
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
}
