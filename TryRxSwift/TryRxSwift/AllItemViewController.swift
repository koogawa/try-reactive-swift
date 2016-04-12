//
//  AllItemViewController.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/12.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import SafariServices
import RxSwift

class AllItemViewController: UITableViewController {
    
    // MARK: - Property
    
    @IBOutlet weak var pullToRefresh: UIRefreshControl!
    var centerIndicator = UIActivityIndicatorView()
    var footerIndicator = UIActivityIndicatorView()
    
    var viewModel = AllItemViewModel()
    var dataSource = AllItemViewDataSource()
    var delegate = AllItemViewDelegate()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureBackgroundColor()
        self.configureTableView()
        self.centerIndicator = self.configureCenterIndicator
        self.footerIndicator = self.configureFooterIndicator
        self.itemRequest()
        self.bind()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Private
    
    private func configureTableView() {
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self.delegate
        self.tableView.rowHeight = 110
        self.tableView.estimatedRowHeight = 110
        self.tableView.registerCell(nibName: "ItemCell", forCellReuseIdentifier: "itemCell")
    }
    
    private func itemRequest() {
        self.viewModel.firstRequest()
    }
    
    func bind() {
        
        self.viewModel.firstLoading
            .asDriver()
            .drive(self.centerIndicator.rx_animating)
            .addDisposableTo(self.disposeBag)
        
        self.pullToRefresh
            .rx_controlEvent(.ValueChanged)
            .subscribe { [weak self] (_) -> Void in
                self?.viewModel.refreshRequest()
            }
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.refreshLoading
            .asDriver()
            .drive(self.pullToRefresh.rx_refreshing)
            .addDisposableTo(self.disposeBag)
        
        self.rx_reachBottom
            .filter { () -> Bool in
                self.footerIndicator.isAnimating() == false
            }
            .subscribe { [weak self] (event) -> Void in
                print("nextPageRequest")
                self?.viewModel.nextPageRequest()
            }
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.nextPageLoading
            .asDriver()
            .drive(self.footerIndicator.rx_animating)
            .addDisposableTo(self.disposeBag)
        
        self.viewModel.items
            .asDriver()
            .drive (
                self.tableView.rx_itemsWithDataSource(self.dataSource)
            )
            .addDisposableTo(self.disposeBag)
        
        self.tableView.rx_itemSelected
            .bindNext { [weak self] (indexPath) -> Void in
                let item = self?.viewModel.items.value[indexPath.row]
                
                if let urlString = item?.url, url = NSURL(string: urlString) {
                    let safariVC = SFSafariViewController(URL: url)
                    self?.presentViewController(
                        safariVC,
                        animated: true,
                        completion: nil
                    )
                }
                
            }
            .addDisposableTo(self.disposeBag)
    }
}
