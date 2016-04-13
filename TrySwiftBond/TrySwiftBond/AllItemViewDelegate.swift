//
//  AllItemViewDelegate.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import SafariServices

extension AllItemViewController {
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let item = self.viewModel.items.array[indexPath.row]
        if let url = NSURL(string: item.url.value) {
            let safariVC = SFSafariViewController(URL: url)
            self.presentViewController(
                safariVC,
                animated: true,
                completion: nil
            )
        }
    }
    
}
