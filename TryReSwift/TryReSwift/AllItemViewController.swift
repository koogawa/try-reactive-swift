//
//  AllItemViewController.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import ReSwift
import SafariServices

class AllItemViewController: UITableViewController, StoreSubscriber {
    
    // MARK: - Property
    
    @IBOutlet weak var pullToRefresh: UIRefreshControl!
    var centerIndicator = UIActivityIndicatorView()
    var footerIndicator = UIActivityIndicatorView()
    
    let store = appStore
    let allItemActionCreator = AllItemActionCreator()
    let dataSource = AllItemViewDataSource()
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureTableView()
        self.configurePullToRefresh()
        self.store.subscribe(self)
        self.itemRequest()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.store.unsubscribe(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private
    
    private func configureTableView() {
        self.tableView.dataSource = self.dataSource
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.rowHeight = 110
        self.tableView.estimatedRowHeight = 110
        let nib = UINib(nibName: "ItemCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "itemCell")
    }
    
    private func configurePullToRefresh() {
        self.pullToRefresh.addTarget(
            self,
            action: #selector(AllItemViewController.refreshRequest),
            forControlEvents: .ValueChanged
        )
    }
    
    private func itemRequest() {
        self.store.dispatch(self.allItemActionCreator.itemRequestWithPage(1))
    }
    
    func refreshRequest() {
        self.store.dispatch(self.allItemActionCreator.itemRequestWithPage(1))
    }

    // MARK: - SetState
    
    func newState(state: AllItemState) {
        
        self.pullToRefresh.endRefreshing()
        
        guard let result = state.itemResult else {
            // TODO: error
            return
        }
        
        switch result {
        case .Success(let value):
            self.dataSource.items = value
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        case .Failure(let error):
            print(error)
        }
    }
    
    // MARK: - UITableView Delegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let item = self.dataSource.items[indexPath.row]
        if let url = NSURL(string: item.url) {
            let safariVC = SFSafariViewController(URL: url)
            self.presentViewController(
                safariVC,
                animated: true,
                completion: nil
            )
        }
        
    }

}
