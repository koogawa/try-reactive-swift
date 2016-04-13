//
//  AllItemViewController.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Bond

class AllItemViewController: UITableViewController {
    
    // MARK: - Property
    
    @IBOutlet weak var pullToRefresh: UIRefreshControl!
    var centerIndicator = UIActivityIndicatorView()
    var footerIndicator = UIActivityIndicatorView()
    
    let viewModel = AllItemViewModel()
    let dataSource = AllItemViewDataSource()
    var items = ObservableArray<ObservableArray<Item>>([])
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureBackgroundColor()
        self.configureTableView()
        self.centerIndicator = self.configureCenterIndicator
        self.footerIndicator = self.configureFooterIndicator
        self.bind()
        self.itemRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private
    
    private func configureTableView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.rowHeight = 110
        self.tableView.estimatedRowHeight = 110
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "itemCell")
    }
    
    private func itemRequest() {
        self.viewModel.firstRequest()
    }
    
    private func bind() {
        
        self.viewModel.firstLoading
            .bindTo(self.centerIndicator.bnd_animating)
        
        self.pullToRefresh.bnd_controlEvent
            .filter { $0 == UIControlEvents.ValueChanged }
            .observe { [weak self] (_) -> Void in
                self?.viewModel.refreshRequest()
        }
        
        self.viewModel.refreshLoading
            .filter{ $0 == false }
            .observe { (_) -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    self.pullToRefresh.endRefreshing()
                })
        }
        
        self.items = ObservableArray([self.viewModel.items])
        self.items.bindTo(self.tableView, proxyDataSource: self.dataSource) { (indexPath, items, tableView) in
            print(indexPath)
            let cell = tableView.dequeueReusableCellWithIdentifier("itemCell", forIndexPath: indexPath) as! ItemCell
            let item = items[indexPath.section][indexPath.row]
            item.user.id.bindTo(cell.userIDLabel.bnd_text).disposeIn(cell.bnd_bag)
            item.title.bindTo(cell.itemTitleLabel.bnd_text).disposeIn(cell.bnd_bag)
            return cell
        }
        
    }

}
