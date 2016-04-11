//
//  AllItemViewModel.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import RxSwift

public final class AllItemViewModel {
    
    // MARK: - Property
    
    private let request = API.AllItemRequest()
    private(set) var items = Variable<[Item]>([])
    private(set) var firstLoading = Variable<Bool>(false)
    private(set) var refreshLoading = Variable<Bool>(false)
    private(set) var nextPageLoading = Variable<Bool>(false)
    
    // MARK: - LifeCycle
    
    init() {
        // NOOP
    }
    
    // MARK: - Public
    
    public func firstRequest() {
        self.firstLoading.value = true
        self.request.page = 1
        self.send()
    }
    
    public func refreshRequest() {
        self.refreshLoading.value = true
        self.request.page = 1
        self.send()
    }
    
    public func nextPageRequest() {
        self.nextPageLoading.value = true
        self.request.page += 1
        self.send()
    }
    
    // MARK: - Private
    
    private func send() {
        
        self.request.send()
            .subscribe { [weak self] (event) -> Void in
                
                self?.firstLoading.value = false
                self?.refreshLoading.value = false
                self?.nextPageLoading.value = false
                
                switch event {
                case .Next(let value):
                    if self?.request.page == 1 {
                        self?.items.value = value
                    } else {
                        self?.items.value += value
                    }
                case .Error(_):
                    ()
                case .Completed:
                    ()
                }
            }
            .addDisposableTo(self.request.disposeBag)
    }
}
