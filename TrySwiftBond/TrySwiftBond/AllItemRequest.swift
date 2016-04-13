//
//  AllItemRequest.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Alamofire

extension API {
    public class AllItemRequest {
        
        // MARK: - Proeprty
        
        var page: Int = 1
        
        // MARK: - LifeCycle
        
        init() {
            // NOOP
        }
        
        // MARK: - Public
        
        public func send(completionHandler: Response<AnyObject, NSError> -> Void) {
            let router = API.Router.AllItem(page: "\(self.page)")
            API.manager.request(router).responseJSON(completionHandler: { response in
                completionHandler(response)
            })
        }
    }
}
