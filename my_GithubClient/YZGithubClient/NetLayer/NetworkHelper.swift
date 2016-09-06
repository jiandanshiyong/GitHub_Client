//
//  NetworkHelper.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/9.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class NetworkHelper: NSObject {
    
    //清除webview 中的cookie缓存
    public static func clearCookies() {
        
        let storage : NSHTTPCookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        for cookie in storage.cookies! {
            storage.deleteCookie(cookie)
        }
        NSUserDefaults.standardUserDefaults()
        
    }
}
