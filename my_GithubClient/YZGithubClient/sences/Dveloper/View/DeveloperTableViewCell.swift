//
//  DeveloperTableViewCell.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/11.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit


class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userInfo: UILabel!
    
    var developer:Developer? {
        didSet{
            if let url = developer?.avatar_url {
                userImage.kf_setImageWithURL(NSURL(string: url)!)
            }
            if let login = developer?.login {
                userName.text = login
            }
            if let email = developer?.email {
                 userInfo.text = email
            }
        }
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
