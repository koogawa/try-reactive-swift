//
//  AllItemReducer.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import ReSwift
import Alamofire

struct AllItemReducer: Reducer {
    typealias ReducerStateType = AllItemState
    
    func handleAction(action: Action, state: ReducerStateType?) -> ReducerStateType {
        let state = state ?? AllItemState()
        
        switch action {
        case let action as AllItemAction:
            return setAllItemAction(state, itemResult: action.itemResult)
        default:
            return state
        }
    }
    
    func setAllItemAction(var state: AllItemState, itemResult: Result<[Item], NSError>) -> AllItemState {
        state.itemResult = itemResult
        return state
    }
}
