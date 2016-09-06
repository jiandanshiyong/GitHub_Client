//
//  loginViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/9.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: BaseWebViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}


extension LoginViewController{
    
    override func webViewDidFinishLoad(webView: UIWebView){
        super.webViewDidFinishLoad(webView)
        
        let url = webView.request?.URL?.absoluteString
//        print(url)
        
        let hasCode = url?.containsString("code=")
        if hasCode == true {
            //获取code
            let range = url?.rangeOfString("code=")
            let startIndex = range?.endIndex
            let endIndex = url?.endIndex
            let code = url?.substringWithRange(startIndex!..<endIndex!)
            feachToken(code!)
        }
    }
    
    //根据code获取token
    func feachToken(code:NSString){
        let param = ["client_id":GithubClient_id,
                    "client_secret":GithubClientSecret,
                    "code":code,
                    "redirect_uri":redirect_uri]
        Alamofire.request(.POST, "https://github.com/login/oauth/access_token", parameters: param).responseString {
            (response) in
            
            switch response.result{
            case let .Success(Value):
//                print("Value :+ \(Value)" )
                //access_token=351fe79cf97e71af5967bbeebf18a3146efb7969
                //&scope=admin%3Aorg%2Cadmin%3Aorg_hook%2Cadmin%3Apublic_key%2Cadmin%3Arepo_hook%2Cdelete_repo%2Cgist%2Cnotifications%2Crepo%2Cuse
                //r&token_type=bearer
                
                let array = Value.componentsSeparatedByString("&")
                let access_token = self.getRightValue(array[0])
               print("access_token : + \(access_token)")
                
                //保存 token
                NSUserDefaults.standardUserDefaults().setObject(access_token, forKey: "token")
                
                NSNotificationCenter.defaultCenter().postNotificationName(Github_loginSuccess, object: nil);
                self.navigationController?.popViewControllerAnimated(true)
                
            case let .Failure(Error):
                print(Error)
            }
        }
    }
    
    
    //截取字符串
    func getRightValue (string:String)->(String){
        //格式：access_token=351fe79cf97e71af5967bbeebf18a3146efb7969
        let range = string.rangeOfString("=")
        let startIndex = range?.endIndex
        let endIndex = string.endIndex
        return string.substringWithRange(startIndex! ..< endIndex)
    }

    
    

}