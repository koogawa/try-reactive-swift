//
//  AllItemRequest.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

extension API {
    public class AllItemRequest {
        
        // MARK: - Property
        
        var page: Int = 1
        let disposeBag = DisposeBag()
        
        // MARK: - LifeCycle
        
        init() {
            // NOOP
        }
        
        // MARK: - Public
        
        public func send() -> Observable<[Item]> {
            return Observable.create{ (observer) in
                let router = API.Router.AllItem(page: "\(self.page)")
                API.manager.request(router).responseJSON(completionHandler: { response in
                    switch response.result {
                    case .Success(let value):
                        // TODO: ObjectMapper
                        guard let value = value as? [[String: AnyObject]] else {
                            return observer.on(.Completed)
                        }
                        let items = value.flatMap{ Item(dictionary: $0) }
                        observer.on(.Next(items))
                        observer.on(.Completed)
                    case .Failure(let error):
                        observer.onError(error)
                    }
                })
                return AnonymousDisposable {
                    // TODO
                }
            }
        }
    }
}
