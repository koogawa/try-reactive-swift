//
//  AllItemViewDataSource.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit

class AllItemViewDataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Property
    
    var items = [Item]()
    
    // MARK: - LifeCycle
    
    // init() {}
    
    // MARK: - UITableView Datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
        let item = self.items[indexPath.row]
        cell.configureCell(item: item)
        return cell
    }
    
}
