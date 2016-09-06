//
//  Message.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/17.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Message:NSObject,Mappable {
    var id:String?
    
    var repository:Repository?
    var subject:Subject?
    
    var reason:String?
    var unread:Int?
    var updated_at:String?
    var last_read_at:String?
    var url:String?
    
    
    required init?(_ map: Map) {
        
    }
    func mapping(map: Map) {
        subject <- map["subject"]
        last_read_at <- map["last_read_at"]
        unread <- map["unread"]
        id <- map["id"]
        updated_at <- map["updated_at"]
        reason <- map["reason"]
        repository <- map["repository"]
        url <- map["url"]
    }
}
