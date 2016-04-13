//
//  User.swift
//  TrySwiftBond
//
//  Created by naoto yamaguchi on 2016/04/13.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import Bond

public class User {
    
    // MARK: - Property
    
    public let id: Observable<String>
    public let profileImageURL: Observable<String>
    
    // MARK: - LifeCycle
    
    init() {
        self.id = Observable("")
        self.profileImageURL = Observable("")
    }
    
    init(dictionary: [String: AnyObject]) {
        self.id = Observable(dictionary["id"] as? String ?? "")
        self.profileImageURL = Observable(dictionary["profile_image_url"] as? String ?? "")
    }
    
}
