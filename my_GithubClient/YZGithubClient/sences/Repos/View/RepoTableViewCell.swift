//
//  RepoTableViewCell.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SwiftDate

class RepoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repoImage: UIImageView!
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoLastActiveTime: UILabel!
    @IBOutlet weak var repoStarNumber: UILabel!
    @IBOutlet weak var repoInfo: UILabel!
    @IBOutlet weak var repoForkNumber: UILabel!
    @IBOutlet weak var repoLanguage: UILabel!

    var repo:Repository? {
        didSet{
            updateUI()
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
    
    func updateUI() {
        repoName.text = repo?.name     
        repoInfo.text = repo?.cdescription
        
        if let forks_count = repo?.forks_count {
            repoForkNumber.text = "\(forks_count)"
        }
        
        if let stargazers_count = repo?.stargazers_count {
             repoStarNumber.text = "\(stargazers_count)"
        }
       
        if let pushed_at = repo?.pushed_at {
             repoLastActiveTime.text = (pushed_at.toDate(DateFormat.ISO8601)?.toRelativeString(abbreviated: false, maxUnits: 1))! + " age"   //日期
        }
        
       
        
        if let lan = repo?.language {
            repoLanguage.text = lan
        }
        
        repoImage.kf_setImageWithURL(NSURL(string: (repo?.owner!.avatar_url)!)!)
    }
    
    
}
