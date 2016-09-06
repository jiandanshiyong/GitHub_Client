//
//  RepoInfoCell.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class RepoInfoCell: UITableViewCell {

    @IBOutlet var imageIcon: UIImageView!
    @IBOutlet var actionName: UILabel!
    
    func customUI(image:UIImage,actionName:String) {
        imageIcon.image = image
        self.actionName.text = actionName
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
