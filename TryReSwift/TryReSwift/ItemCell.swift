//
//  ItemCell.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import WebImage

class ItemCell: UITableViewCell {
    
    // MARK: - Property
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Public
    
    func configureCell(item item: Item) {
        if let url = NSURL(string: item.user.profileImageURL) {
            self.userImageView.sd_setImageWithURL(
                url,
                placeholderImage: nil,
                options: .RetryFailed
            )
        }
        
        self.userIDLabel.text = item.user.id
        self.itemTitleLabel.text = item.title
    }
}
