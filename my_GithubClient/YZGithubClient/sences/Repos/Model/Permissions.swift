//
//  Permissions.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Permissions:NSObject,Mappable {
    var pull:Int?
    var admin:Int?
    var push:Int?
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        pull <- map["pull"]
        admin <- map["admin"]
        push <- map["push"]
    }
}