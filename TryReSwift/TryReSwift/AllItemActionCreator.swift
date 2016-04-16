//
//  AllItemActionCreator.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import ReSwift

struct AllItemActionCreator {
    
    func itemRequestWithPage(page: Int) -> Store<AllItemState>.ActionCreator {
        return { state, store in
            AllItemRequest.sharedInstance.page = page
            AllItemRequest.sharedInstance.send({ response in
                store.dispatch(AllItemAction(itemResult: response))
            })
            
            return nil
        }
    }
}
