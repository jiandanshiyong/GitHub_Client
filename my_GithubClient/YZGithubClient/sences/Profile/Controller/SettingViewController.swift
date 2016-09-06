//
//  SettingViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/11.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import Kingfisher

class SettingViewController: UIViewController {
    
    let tableView:UITableView = UITableView(frame: CGRectZero, style: .Grouped)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
    }

    func customUI(){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.top.left.equalTo(self.view)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
 
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension SettingViewController:UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath)
        
        let index = (indexPath.section, indexPath.row)
        switch index {
        case (0,0):
            
            let manager = KingfisherManager.sharedManager
            manager.cache.calculateDiskCacheSizeWithCompletionHandler({ (size) in
                cell.textLabel?.text = "清除缓存     \(size/1024/1024)M"
            })
            
        case (1,0):
            cell.textLabel?.text = "退出"
        default:
            cell.textLabel?.text = "未定义"
        }
        
        return cell
    }
}

extension SettingViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = (indexPath.section,indexPath.row)
                switch index {
                case (0,0):  //清除缓存
                    self.view.hudMessage("清除缓存成功")
                    let manager = KingfisherManager.sharedManager
                    manager.cache.clearDiskCacheWithCompletionHandler({ 
                        let cell = tableView.cellForRowAtIndexPath(indexPath)
                        cell?.textLabel?.text = "缓存  0 M"
                    })
                case (1,0): //退出
                    //清除token
                    NSUserDefaults.standardUserDefaults().removeObjectForKey("token")
                    
                    NSNotificationCenter.defaultCenter().postNotificationName(Github_logoutSuccess, object: nil)
                    navigationController?.popViewControllerAnimated(true)
                    print("退出")
                   
        
                default:
                    print("未定义")
                }
    }

}

