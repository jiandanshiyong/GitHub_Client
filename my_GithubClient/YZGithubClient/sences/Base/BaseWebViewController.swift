//
//  BaseWebViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/9.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import MBProgressHUD

class BaseWebViewController: UIViewController {
    
    var webView  = UIWebView()
    
    var url:String?{
        didSet{
            let request = NSURLRequest(URL: NSURL(string: url!)!)
            NetworkHelper.clearCookies() //清除cookie缓存
            webView.loadRequest(request)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self;
        customUI()
    }
    
    
    func customUI (){
        view.addSubview(webView)
        webView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.top.left.equalTo(self.view)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension BaseWebViewController:UIWebViewDelegate{
    func webViewDidStartLoad(webView: UIWebView) {
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.mode = .Indeterminate //转圈Hud
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
        self.view.hudError("网页加载失败")
    }

}






