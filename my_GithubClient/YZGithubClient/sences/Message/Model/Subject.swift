//
//  Subject.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/17.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Subject:NSObject,Mappable {
    var title:String?
    var type:String?
    var latest_comment_url:String?
    var url:String?
    
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        title <- map["title"]
        type <- map["type"]
        latest_comment_url <- map["latest_comment_url"]
        url <- map["url"]
    }
}
