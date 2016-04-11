//
//  ItemCellModel.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import RxSwift

public final class ItemCellModel {
    
    // MARK: - Property
    
    private(set) var imageURL = Variable<String>("")
    private(set) var userID = Variable<String>("")
    private(set) var title = Variable<String>("")
    
    // MARK: - Public
    
    public func configureCell(item item: Item) {
        self.imageURL.value = item.user.profileImageURL
        self.userID.value = item.user.id
        self.title.value = item.title
    }
}
