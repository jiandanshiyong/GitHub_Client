//
//  User.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/10.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class Developer:NSObject,Mappable,NSCoding {
    var total_private_repos:Int?
    var public_repos:Int?
    var repos_url:String?
    var location:String?
    var followers:Int?
    var bio:String?
    var organizations_url:String?
    var type:String?
    var blog:String?
    var starred_url:String?
    var owned_private_repos:Int?
    var id:Int?
    var name:String?
    var following:Int?
    var gists_url:String?
    var following_url:String?
    var updated_at:String?
    var collaborators:Int?
    var avatar_url:String?
    var gravatar_id:String?
    var url:String?
    var followers_url:String?
    var created_at:String?
    var private_gists:Int?
    var disk_usage:Int?
    var company:String?
    var hireable:Int?
    var login:String?
    var site_admin:Int?
    var public_gists:Int?
    var received_events_url:String?
    var email:String?
    var plan:Plan?
    var subscriptions_url:String?
    var events_url:String?
    var html_url:String?
    
    override init() {
        
    }
    
    //ObjectMapper 方法
    required init?(_ map: Map) {
        
    }

    func mapping(map: Map) {
        total_private_repos <- map["total_private_repos"]
        public_repos <- map["public_repos"]
        repos_url <- map["repos_url"]
        location <- map["location"]
        followers <- map["followers"]
        bio <- map["bio"]
        organizations_url <- map["organizations_url"]
        type <- map["type"]
        blog <- map["blog"]
        starred_url <- map["starred_url"]
        owned_private_repos <- map["owned_private_repos"]
        id <- map["id"]
        name <- map["name"]
        following <- map["following"]
        gists_url <- map["gists_url"]
        following_url <- map["following_url"]
        updated_at <- map["updated_at"]
        collaborators <- map["collaborators"]
        avatar_url <- map["avatar_url"]
        gravatar_id <- map["gravatar_id"]
        url <- map["url"]
        followers_url <- map["followers_url"]
        created_at <- map["created_at"]
        private_gists <- map["private_gists"]
        disk_usage <- map["disk_usage"]
        company <- map["company"]
        hireable <- map["hireable"]
        login <- map["login"]
        site_admin <- map["site_admin"]
        public_gists <- map["public_gists"]
        received_events_url <- map["received_events_url"]
        email <- map["email"]
        plan <- map["plan"]
        subscriptions_url <- map["subscriptions_url"]
        events_url <- map["events_url"]
        html_url <- map["html_url"]
    }
    
    //反归档
    required init?(coder aDecoder: NSCoder){
        super.init()
        total_private_repos = aDecoder.decodeObjectForKey("total_private_repos") as? Int
        public_repos = aDecoder.decodeObjectForKey("public_repos") as? Int
        repos_url = aDecoder.decodeObjectForKey("repos_url") as? String
        location = aDecoder.decodeObjectForKey("location") as? String
        followers = aDecoder.decodeObjectForKey("followers") as? Int
        bio = aDecoder.decodeObjectForKey("bio") as? String
        organizations_url = aDecoder.decodeObjectForKey("organizations_url") as? String
        type = aDecoder.decodeObjectForKey("type") as? String
        blog = aDecoder.decodeObjectForKey("blog") as? String
        starred_url = aDecoder.decodeObjectForKey("starred_url") as? String
        owned_private_repos = aDecoder.decodeObjectForKey("owned_private_repos") as? Int
        id = aDecoder.decodeObjectForKey("id") as? Int
        name = aDecoder.decodeObjectForKey("name") as? String
        following = aDecoder.decodeObjectForKey("following") as? Int
        gists_url = aDecoder.decodeObjectForKey("gists_url") as? String
        following_url = aDecoder.decodeObjectForKey("following_url") as? String
        updated_at = aDecoder.decodeObjectForKey("updated_at") as? String
        collaborators = aDecoder.decodeObjectForKey("collaborators") as? Int
        avatar_url = aDecoder.decodeObjectForKey("avatar_url") as? String
        gravatar_id = aDecoder.decodeObjectForKey("gravatar_id") as? String
        url = aDecoder.decodeObjectForKey("url") as? String
        followers_url = aDecoder.decodeObjectForKey("followers_url") as? String
        created_at = aDecoder.decodeObjectForKey("created_at") as? String
        private_gists = aDecoder.decodeObjectForKey("private_gists") as? Int
        disk_usage = aDecoder.decodeObjectForKey("disk_usage") as? Int
        company = aDecoder.decodeObjectForKey("company") as? String
        hireable = aDecoder.decodeObjectForKey("hireable") as? Int
        login = aDecoder.decodeObjectForKey("login") as? String
        site_admin = aDecoder.decodeObjectForKey("site_admin") as? Int
        public_gists = aDecoder.decodeObjectForKey("public_gists") as? Int
        received_events_url = aDecoder.decodeObjectForKey("received_events_url") as? String
        email = aDecoder.decodeObjectForKey("email") as? String
        plan = aDecoder.decodeObjectForKey("plan") as? Plan
        subscriptions_url = aDecoder.decodeObjectForKey("subscriptions_url") as? String
        events_url = aDecoder.decodeObjectForKey("events_url") as? String
        html_url = aDecoder.decodeObjectForKey("html_url") as? String
    }
    
    //归档
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(total_private_repos, forKey:"total_private_repos")
        aCoder.encodeObject(public_repos, forKey:"public_repos")
        aCoder.encodeObject(repos_url, forKey:"repos_url")
        aCoder.encodeObject(location, forKey:"location")
        aCoder.encodeObject(followers, forKey:"followers")
        aCoder.encodeObject(bio, forKey:"bio")
        aCoder.encodeObject(organizations_url, forKey:"organizations_url")
        aCoder.encodeObject(type, forKey:"type")
        aCoder.encodeObject(blog, forKey:"blog")
        aCoder.encodeObject(starred_url, forKey:"starred_url")
        aCoder.encodeObject(owned_private_repos, forKey:"owned_private_repos")
        aCoder.encodeObject(id, forKey:"id")
        aCoder.encodeObject(name, forKey:"name")
        aCoder.encodeObject(following, forKey:"following")
        aCoder.encodeObject(gists_url, forKey:"gists_url")
        aCoder.encodeObject(following_url, forKey:"following_url")
        aCoder.encodeObject(updated_at, forKey:"updated_at")
        aCoder.encodeObject(collaborators, forKey:"collaborators")
        aCoder.encodeObject(avatar_url, forKey:"avatar_url")
        aCoder.encodeObject(gravatar_id, forKey:"gravatar_id")
        aCoder.encodeObject(url, forKey:"url")
        aCoder.encodeObject(followers_url, forKey:"followers_url")
        aCoder.encodeObject(created_at, forKey:"created_at")
        aCoder.encodeObject(private_gists, forKey:"private_gists")
        aCoder.encodeObject(disk_usage, forKey:"disk_usage") 
        aCoder.encodeObject(company, forKey:"company") 
        aCoder.encodeObject(hireable, forKey:"hireable") 
        aCoder.encodeObject(login, forKey:"login") 
        aCoder.encodeObject(site_admin, forKey:"site_admin") 
        aCoder.encodeObject(public_gists, forKey:"public_gists") 
        aCoder.encodeObject(received_events_url, forKey:"received_events_url") 
        aCoder.encodeObject(email, forKey:"email") 
        aCoder.encodeObject(plan, forKey:"plan") 
        aCoder.encodeObject(subscriptions_url, forKey:"subscriptions_url") 
        aCoder.encodeObject(events_url, forKey:"events_url") 
        aCoder.encodeObject(html_url, forKey:"html_url") 
    }
    
    
    
    //1. 将一个自定义对象保存到沙盒（归档）
    func saveDeveloper() -> Bool{
        let isSave = NSKeyedArchiver.archiveRootObject(self, toFile: self.pathOfMyInfo())
        return isSave
    }

    
    //2.从沙盒读取一个已归档的对象（反归档）
    func loadDeveloper() -> Developer? {
        let deve = NSKeyedUnarchiver.unarchiveObjectWithFile(pathOfMyInfo()) as? Developer
        return deve
    }
    
    //获取归档文件路径
    func pathOfMyInfo () -> String{
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first
        let filePath = path! + "/userinfo"
        return filePath
    }
    
}


















