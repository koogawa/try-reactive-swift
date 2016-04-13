//
//  AllItemViewModel.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Bond

public final class AllItemViewModel {
    
    // MARK: - Property
    
    private let request = API.AllItemRequest()
    private(set) var items = ObservableArray<Item>([])
    private(set) var firstLoading = Observable<Bool>(false)
    private(set) var refreshLoading = Observable<Bool>(false)
    
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
    
    // MARK: - Private
    
    private func send() {
        self.request.send { [weak self] (response) -> Void in
            
            self?.firstLoading.value = false
            self?.refreshLoading.value = false
            
            switch response.result {
            case .Success(let value):
                guard let value = value as? [[String: AnyObject]] else {
                    // TODO:
                    print("error guard")
                    return
                }
                let items = value.flatMap { Item(dictionary: $0) }
                print("finish request")
                if self?.request.page == 1 {
                    self?.items.array = items
                } else {
                    self?.items.array += items
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
}
