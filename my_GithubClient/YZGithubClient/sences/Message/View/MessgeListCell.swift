//
//  MessgeListCell.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/17.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SwiftDate

class MessgeListCell: UITableViewCell {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detaiLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    var message:Message? {
        didSet{
            if let type = message?.subject?.type {
                print("type: \(type)")
                
//                switch type {
//                case "Issue":
//                    self.imgView.image = UIImage(named: "octicon_issue_25")
//                case "pull_request":
//                    self.imgView.image = UIImage(named: "octicon_pull_request_25")
//                default:
//                    self.imgView.image = UIImage(named: "octicon_issue_25")
//                }
            }
            if let title = message?.subject?.title {
                titleLabel.text = title
            }
            
            if let name = message?.repository?.owner?.name {
                detaiLabel.text = name
            }
            if let updated_at = message?.updated_at {
                timeLabel.text = (updated_at.toDate(DateFormat.ISO8601)?.toRelativeString(abbreviated: false, maxUnits: 1))! + " Day"   //日期
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
