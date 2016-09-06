//
//  UIView+HUD.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/11.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import MBProgressHUD

extension UIView {
    func hudMessage(message:String){
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.labelText = message
        hud.mode = .Text
        hud.hide(true,afterDelay: 1.5)
    }
    
    func hudError(error:String){
        let hud = MBProgressHUD.showHUDAddedTo(self, animated: true)
        hud.labelText = error
        
        hud.hide(true,afterDelay: 2)
    
    }
 

}
