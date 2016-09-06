//
//  RepoListViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class RepoListViewController: UIViewController {
    
    var developer:Developer? = nil //开发者
    var reposArray = [Repository]() //仓库数组
    
    let tableView:UITableView = UITableView.init(frame: CGRectZero, style: .Plain)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "仓库列表"

        customUI()
        fetchRepoList()
    }
    
    func customUI (){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self.view)
            make.size.equalTo(self.view)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        tableView.registerNib(UINib(nibName:"RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
    }
    
    func fetchRepoList(){
        let provider = Provider.shareProvider
        provider.request(GithubAPI.UserRepos(username: (developer?.login)!)) { (result) in
            switch result{
            case let .Success(response):
                //Response Moya框架的
                do{
                    
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Repository>() //2.使用model构建解析器
                    self.reposArray = mapper.mapArray(json)!  //3.解析并返回对象
                    
                    self.tableView .reloadData()
                    
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

extension RepoListViewController: UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reposArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCellWithIdentifier("RepoTableViewCell") as? RepoTableViewCell
        
        cell?.repo = self.reposArray[indexPath.row]
        return cell!
    }

}

extension RepoListViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       let repoInfoVC = RepoInfoViewController()
        repoInfoVC.repoInfo = self.reposArray[indexPath.row]
        navigationController?.pushViewController(repoInfoVC, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }

}

