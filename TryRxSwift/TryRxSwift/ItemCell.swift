//
//  ItemCell.swift
//  TryRxSwift
//
//  Created by naoto yamaguchi on 2016/04/11.
//  Copyright © 2016年 naoto yamaguchi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import WebImage

class ItemCell: UITableViewCell {
    
    // MARK: - Property
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIDLabel: UILabel!
    @IBOutlet weak var itemTitleLabel: UILabel!
    let cellModel = ItemCellModel()
    let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.bind()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Private
    
    private func bind() {
        
        self.cellModel.imageURL
            .asDriver()
            .filter { (text) -> Bool in
                text.characters.count > 0
            }
            .driveNext { (text) -> Void in
                if let url = NSURL(string: text) {
                    self.userImageView.sd_setImageWithURL(
                        url,
                        placeholderImage: nil,
                        options: .RetryFailed
                    )
                }
            }
            .addDisposableTo(self.disposeBag)
        
        self.cellModel.userID
            .asDriver()
            .drive(self.userIDLabel.rx_text)
            .addDisposableTo(self.disposeBag)
        
        self.cellModel.title
            .asDriver()
            .drive(self.itemTitleLabel.rx_text)
            .addDisposableTo(self.disposeBag)
    }
}
