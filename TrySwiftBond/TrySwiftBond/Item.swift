//
//  Item.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Bond

public class Item {
    
    // MARK: - Property
    
    public let id: Observable<String>
    public let title: Observable<String>
    public let url: Observable<String>
    public let user: User
    
    // MARK: - Public
    
    init(dictionary: [String: AnyObject]) {
        self.id = Observable(dictionary["id"] as? String ?? "")
        self.title = Observable(dictionary["title"] as? String ?? "")
        self.url = Observable(dictionary["url"] as? String ?? "")
        
        if let userDictionary = dictionary["user"] as? [String: AnyObject] {
            self.user = User(dictionary: userDictionary)
        } else {
            self.user = User()
        }
    }
}
