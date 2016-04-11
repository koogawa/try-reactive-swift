//
//  AllItemViewDelegate.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/12.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit

public final class AllItemViewDelegate: NSObject, UITableViewDelegate {
    
    // MARK: - UITableView Delegate
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
