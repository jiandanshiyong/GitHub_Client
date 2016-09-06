//
//  Plan.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/10.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Plan:NSObject,Mappable,NSCoding {
    var name:String?
    var collaborators:Int?
    var space:Int?
    var private_repos:Int?
    
    //ObjectMapper 方法
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        name <- map["name"]
        collaborators <- map["collaborators"]
        space <- map["space"]
        private_repos <- map["private_repos"]
    }
    
    //反归档代码
    required init?(coder aDecoder: NSCoder){
        super.init()
        name = aDecoder.decodeObjectForKey("name") as? String
        collaborators = aDecoder.decodeObjectForKey("collaborators") as? Int
        space = aDecoder.decodeObjectForKey("space") as? Int
        private_repos = aDecoder.decodeObjectForKey("private_repos") as? Int
    }
    
    //归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey:"name")
        aCoder.encodeObject(collaborators, forKey:"collaborators")
        aCoder.encodeObject(space, forKey:"space")
        aCoder.encodeObject(private_repos, forKey:"private_repos")
    }
    
}

