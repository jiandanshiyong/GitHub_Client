//
//  MessageListViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/17.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper

class MessageListViewController: BaseViewController {
    
    var messageArrary = [Message]()
    let tableView:UITableView = UITableView(frame:CGRectZero, style:.Plain)

    override func viewDidLoad() {
        super.viewDidLoad()

        customUI()
        fetchData()
    }
    
    func customUI () {
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.top.left.equalTo(self.view)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifer")
        tableView.registerNib(UINib(nibName: "MessgeListCell", bundle: nil), forCellReuseIdentifier: "MessgeListCell")
    }

    func fetchData() {
        let provider = Provider.shareProvider
        provider.request(GithubAPI.MyNotifications) { (result) in
            switch (result){
            case let .Success(response):
                do{
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                 //1.model 实现协议
                    let mapper = Mapper<Message>() //2.使用model构建解析器
                    self.messageArrary = mapper.mapArray(json)!  //3.解析并返回对象
      
                    self.tableView .reloadData()
                }catch{
                    print("JSON 解析失败")
                }
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

extension MessageListViewController:UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messageArrary.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessgeListCell") as? MessgeListCell
        
        cell?.message = self.messageArrary[indexPath.row]
        return cell!
    }
}

extension MessageListViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}

