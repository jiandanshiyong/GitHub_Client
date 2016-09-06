//
//  AppDelegate.swift
//  YZGithubClient
//
//  Created by 郑建文 on 16/8/9.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        customUI()
        
        //设置友盟的key
        UMSocialData.setAppKey("56025946e0f55a744000439c")
        
        //设置新浪 key
        UMSocialSinaSSOHandler.openNewSinaSSOWithAppKey("3006877935", secret: "46fd11d135010fcc578a1b0ced7e50d4", redirectURL: "https://api.weibo.com/oauth2/default.html")
        
        return true
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        
        print("\(url.absoluteString) : \(sourceApplication)")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func customUI(){
        //通过全局属性来设置控件样式
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().barTintColor = UIColor.navBarTintColor()
        //所有的导航栏的title文字属性
        UINavigationBar.appearance().titleTextAttributes = NSDictionary.init(object: UIColor.whiteColor(), forKey: NSForegroundColorAttributeName) as? [String : AnyObject]
        
        //tintcolor 控件文字颜色
        // barTintColor = 控件颜色(背景颜色)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        //TODO: 代码设置bartintColor
    }

}

