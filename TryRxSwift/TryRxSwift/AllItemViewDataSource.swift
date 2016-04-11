//
//  AllItemViewDataSource.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public final class AllItemViewDataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    
    // MARK: - Alias
    
    public typealias Element = [Item]
    
    // MARK: - Property
    
    private var items = [Item]()
    
    // MARK: - RxTableView DataSourceType
    
    public func tableView(tableView: UITableView, observedEvent: Event<Element>) {
        switch observedEvent {
        case .Next(let value):
            self.items = value
            tableView.reloadData()
        case .Error(_):
            ()
        case .Completed:
            ()
        }
    }
    
    // MARK: - UITableView DataSource
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
        let item = self.items[indexPath.row]
        cell.cellModel.configureCell(item: item)
        return cell
    }
    
}
