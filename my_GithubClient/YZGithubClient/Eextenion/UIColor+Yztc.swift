//
//  UIColor+Yztc.swift
//  YZGithubClient
//
//  Created by 郑建文 on 16/8/9.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

extension UIColor {
    //把16进制字符串转成UIColor
    class func hexStr(hexStr : NSString,alpha : CGFloat) -> UIColor {
        let realHexStr = hexStr.stringByReplacingOccurrencesOfString("#", withString: "")
        let scanner = NSScanner(string: realHexStr as String)
        var color:UInt32 = 0
        
        // 把16进制的字符串转成 Int 数据放到color变量中
        // bool
        if scanner.scanHexInt(&color) {
            // & 与运算符
            let r = CGFloat( (color & 0xFF0000) >> 16 ) / 255.0
            let g = CGFloat( (color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat( (color & 0x0000FF) ) / 255.0
            return UIColor(red: r, green: g, blue: b, alpha: alpha)
        }else{
            print("invalid hex string",terminator:"")
            return UIColor.whiteColor()
        }
    }
    //导航栏颜色
    class func navBarTintColor() -> UIColor {
        return self.hexStr("006b13", alpha: 1)
    }
    
}
