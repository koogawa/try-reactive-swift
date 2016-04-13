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
    
    public let id: String
    public let title: String
    public let url: String
    public let user: User
    
    // MARK: - Public
    
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String ?? ""
        self.title = dictionary["title"] as? String ?? ""
        self.url = dictionary["url"] as? String ?? ""
        
        if let userDictionary = dictionary["user"] as? [String: AnyObject] {
            self.user = User(dictionary: userDictionary)
        } else {
            self.user = User()
        }
    }
}
