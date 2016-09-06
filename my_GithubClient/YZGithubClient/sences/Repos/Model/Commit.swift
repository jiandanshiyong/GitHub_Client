//
//  Commit.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/15.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Commit:NSObject,Mappable {
    var sha:String?
    var url:String?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        sha <- map["sha"]
        url <- map["url"]
    }
}
