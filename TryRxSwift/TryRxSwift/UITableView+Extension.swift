//
//  UITableView+Extension.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit

extension UITableView {
    
    // MARK: - Public
    
    public func registerCell(nibName nibName: String, forCellReuseIdentifier: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        self.registerNib(nib, forCellReuseIdentifier: forCellReuseIdentifier)
    }
}
