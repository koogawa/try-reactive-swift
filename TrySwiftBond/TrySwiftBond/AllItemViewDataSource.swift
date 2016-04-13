//
//  AllItemViewDataSource.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Bond

class AllItemViewDataSource: NSObject, BNDTableViewProxyDataSource {
    
    // MARK: - BNDTableView Proxy DataSource
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    func shouldReloadInsteadOfUpdateTableView(tableView: UITableView) -> Bool {
        return true
    }
    
}
