//
//  DeveloperListViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/11.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper

class DeveloperListViewController: UIViewController {
    
    var userArray = [Developer]() //开发者列表
    var target:GithubAPI? {
        didSet{     //target只要有值就发起网络请求 观察属性
            fetchList()
        }
    }

    let tableView:UITableView =  UITableView(frame:CGRectZero, style:.Plain)
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
    }
    
    func customUI (){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.left.top.equalTo(self.view)
            make.size.equalTo(self.view)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        tableView.registerNib(UINib(nibName: "DeveloperTableViewCell",bundle: nil), forCellReuseIdentifier: "DeveloperTableViewCell")
    }

    //MARK: 用户数据请求
    func fetchList() {
        let provider = Provider.shareProvider
        provider.request(target!) { (result) in
            switch result{
            case let .Success(response):
                //Response Moya框架的
                do{
//                    let jsonStr = try response.mapString()
//                    print(jsonStr)
                    
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Developer>() //2.使用model构建解析器
                    self.userArray = mapper.mapArray(json)! //3.解析并返回对象
              
                    self.tableView.reloadData()
                }catch{
                    print("JSON 解析失败")
                }
                print("网络请求成功")
                
            case let .Failure(error):
                print("网络请求失败")
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DeveloperListViewController:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeveloperTableViewCell", forIndexPath: indexPath) as? DeveloperTableViewCell
        
        let developer:Developer = self.userArray[indexPath.row]
        cell?.developer = developer
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let devInfo = DeveloperViewController()
   
        let developer:Developer = self.userArray[indexPath.row]
        devInfo.developer = developer
        self.navigationController?.pushViewController(devInfo, animated: true)
    }
}


extension DeveloperListViewController:UITableViewDelegate{
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 100
    }
}

