//
//  GithubAPI.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/10.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Moya
import Alamofire

//endpoint 解析器 ,将endpoint 解析为Request
func endpointResolver() -> MoyaProvider<GithubAPI>.RequestClosure {
    return { (endpoint,closure) in
        let request:NSMutableURLRequest = endpoint.urlRequest.mutableCopy() as! NSMutableURLRequest
        //设置是否发送和保存cookie
        request.HTTPShouldHandleCookies = false
        //执行这个request
        closure(request)
    }
}

//根据一个targettype 来获取url
public func url(route:TargetType) -> String{
    return route.baseURL.URLByAppendingPathComponent(route.path).absoluteString
}

class GitHubPorvider<Target where Target:TargetType>:MoyaProvider<Target> {
    override init(endpointClosure: Target -> Endpoint<Target>, requestClosure: (Endpoint<Target>, NSURLRequest -> Void) -> Void, stubClosure: Target -> StubBehavior, manager: Manager, plugins: [PluginType]) {
        super.init(endpointClosure: endpointClosure, requestClosure: requestClosure, stubClosure: stubClosure, manager: manager, plugins: plugins)
    }
}

// 网络提供者
struct Provider {
    // 将一个target 转换成 endPoint
    private static var endpointsClosure = { (target:GithubAPI) -> Endpoint<GithubAPI> in
        //根据一个target创建一个endpoint
        var endpoint:Endpoint<GithubAPI> = Endpoint<GithubAPI>(URL:url(target), sampleResponseClosure: {EndpointSampleResponse.NetworkResponse(200,target.sampleData)},method: target.method, parameters: target.parameters)
        
//        switch target {
//        case GithubAPI.MyInfo:
////            endpoint.endpointByAddingHTTPHeaderFields(["name":"zjw"])
//            
//        default:
//            return endpoint
//        }
        
        let token = NSUserDefaults.standardUserDefaults().objectForKey("token")
        
        //给协议头 添加 token
        if(token != nil){
            return endpoint.endpointByAddingHTTPHeaderFields(["Authorization":"token \(token!)"])
        }else{
            return endpoint
        }
 
    }
    
    //通过类属性， 实现单例
    static let shareProvider =  GitHubPorvider(endpointClosure: endpointsClosure, requestClosure: endpointResolver(), stubClosure: MoyaProvider.NeverStub , manager:Alamofire.Manager.sharedInstance , plugins: [])
    
}




//设置一个枚举，用来列举所有的网络请求借口
enum GithubAPI{
    case MyInfo
    case UserInfo(username:String)
    
    case MyFollower
    
    case UserFollower(username:String)  //  users/jianwen-zheng/followers
    
                                        //GET /user/repos
    case UserRepos(username:String)   // GET /users/:username/repos
    
    case RepoBranches(owner:String,repo:String)   // GET /repos/:owner/:repo/branches
    
    case AllRposSince(since:Int)  //GET /repositories
    
    case SearchReposWithKeyWord(keyword:String, page: Int)  //GET /search/repositories
    
    case MyNotifications //Get /notifications
}

//对枚举进行扩展，（遵循协议）
extension GithubAPI:TargetType{
    
    //遵循协议中的属性要求
    //计算属性
    //定义基本接口
    var baseURL: NSURL {
        return NSURL(string: "https://api.github.com/")!
    }
    
    //接口后半部分
    var path: String {
        switch self {
        case .MyInfo:                   //个人信息
            return "user"
        case .UserInfo(let username):   //查询某个用户的信息
            return "users/\(username)"
            
        case .MyFollower:              //经过身份验证的用户 关注的人（我关注的人）
            return "user/following"
            
        case let .UserFollower(username):   //列出用户的 粉丝
            return "users/\(username)/followers"
        
        case let .UserRepos(username):      //指定用户的 所有仓库
            return "users/\(username)/repos"
            
        case let .RepoBranches(owner, repo):   //查看指定用户 指定仓库的分支
           return "repos/\(owner)/\(repo)/branches"
            
        case .AllRposSince(_): //所有的公共仓库
            return "repositories"
         
        case .SearchReposWithKeyWord(_, _):  //查询
            return "search/repositories"
            
        case .MyNotifications:  //所有提示消息
            return "notifications"
            
        default:
            return ""
        }
    }
    
    //接口对应的方法
    var method: Moya.Method {
        switch self {
        case .MyInfo, .UserInfo, .MyFollower, .RepoBranches, .MyNotifications:
            return .GET
        case  .UserFollower(_), .UserRepos(_):
            return .GET
        case  .AllRposSince(_):
            return .GET
        case .SearchReposWithKeyWord(_, _): //查询
            return .GET
        
            
            
        default:
            return .POST
        }
    }
    
    //接口对应的参数
    var parameters: [String: AnyObject]? {
        switch self {
        case .MyInfo:
            return [:]
        case .AllRposSince(let since): //判断枚举类型 拼接参数
            return ["since":since]
        
        case let .SearchReposWithKeyWord(keyword, page):  //查询
            return ["q":keyword,
                    "page":page,
                    "sort":"stars",
                    "order":"desc"]
            
        default:
            return [:]
        }
    }
    
    //单元测试时的值
    var sampleData: NSData {
        return "".dataUsingEncoding(NSUTF8StringEncoding)!
    }

}