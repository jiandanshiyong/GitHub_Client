//
//  Branches.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/13.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Branches:NSObject,Mappable {
    var commit:Commit?
//    var protected:Int?
//    var protection_url:String?
    var name:String?

    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        commit <- map["commit"]
//        protected <- map["protected"]
//        protection_url <- map["protection_url"]
        name <- map["name"]
    }
}

/*
 [
     {
         "name": "master",
         "commit": {
             "sha": "6dcb09b5b57875f334f61aebed695e2e4193db5e",
             "url": "https://api.github.com/repos/octocat/Hello-World/commits/c5b97d5ae6c19d5c5df71a34c7fbeeda2479ccbc"
         },
         "protected": true,
         "protection_url": "https://api.github.com/repos/octocat/Hello-World/branches/master/protection"
     }
 ]
 */