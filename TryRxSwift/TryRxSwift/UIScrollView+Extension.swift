//
//  UIScrollView+Extension.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/12.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit

extension UIScrollView {
    
    // MARK: - Public
    
    public func reachBottom() -> Bool {
        return (self.contentOffset.y >= (self.contentSize.height - self.bounds.size.height - 45))
    }
}
