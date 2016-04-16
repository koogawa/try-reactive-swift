//
//  AllItemAction.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import ReSwift
import Alamofire

public struct AllItemAction: Action {
    let itemResult: Result<[Item], NSError>
    init(itemResult: Result<[Item], NSError>) {
        self.itemResult = itemResult
    }
}
