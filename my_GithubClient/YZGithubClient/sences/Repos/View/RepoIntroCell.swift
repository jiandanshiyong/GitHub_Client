//
//  RepoIntroCell.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class RepoIntroCell: UITableViewCell {
    
    @IBOutlet var repoImage: UIImageView!
    @IBOutlet var repoName: UILabel!
    @IBOutlet var repoAuthor: UILabel!
    @IBOutlet var repoIntro: UILabel!
    
    var repoinfo:Repository? {
        didSet{
            self.selectionStyle = .None
            repoImage.kf_setImageWithURL(NSURL(string: (repoinfo!.owner!.avatar_url)!)!)
            repoName.text = repoinfo?.name
            repoAuthor.text = repoinfo?.owner?.login
            repoIntro.text = repoinfo?.cdescription
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
