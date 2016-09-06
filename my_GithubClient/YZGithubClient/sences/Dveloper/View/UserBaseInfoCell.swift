//
//  UserBaseInfoCell.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class UserBaseInfoCell: UITableViewCell {
    
    @IBOutlet weak var attrNameLabel: UILabel!
    @IBOutlet weak var attrValueLabel: UILabel!

    
    func customUI(name name:String, value:String) {
        attrNameLabel.text = name
        attrValueLabel.text = value
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
