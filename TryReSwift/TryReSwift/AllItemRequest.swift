//
//  AllItemRequest.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Alamofire

public class AllItemRequest {
    
    // MARK: - Property
    
    var page: Int = 1
    
    // MARK: - Singleton
    
    static let sharedInstance = AllItemRequest()
    
    // MARK: - LifeCycle
    
    init() {
        // NOOP
    }
    
    // MARK: - Public
    
    public func send(completionHandler: Result<[Item], NSError> -> Void) {
        let router = API.Router.AllItem(page: "\(self.page)")
        API.manager.request(router).responseJSON(completionHandler: { response in
            switch response.result {
            case .Success(let value):
                guard let value = value as? [[String: AnyObject]] else {
                    print("error: valid arch")
                    // TODO: error handle
                    return
                }
                let items = value.flatMap { Item(dictionary: $0) }
                completionHandler(.Success(items))
            case .Failure(let error):
                completionHandler(.Failure(error))
            }
        })
    }
}
