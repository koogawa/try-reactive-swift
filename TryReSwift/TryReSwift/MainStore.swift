//
//  MainStore.swift
//  TryReSwift
//
//  Created by naoto yamaguchi on 2016/04/16.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import ReSwift

let appStore = Store(reducer: AllItemReducer(), state: AllItemState())
