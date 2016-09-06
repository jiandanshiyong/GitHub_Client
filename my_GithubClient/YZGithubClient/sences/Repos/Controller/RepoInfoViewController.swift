//
//  RepoInfoViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class RepoInfoViewController: UIViewController {
    
    var branches:[Branches]?   //分支数组
    let tableView:UITableView = UITableView(frame:CGRectZero, style:.Grouped)
    
    var repoInfo:Repository?{    //一个仓库  包含一个仓库的所有信息
        didSet{
            fetchBranches()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = repoInfo?.name
        customUI()
    }
    
    func customUI(){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifer")
        tableView.registerNib(UINib(nibName: "RepoIntroCell", bundle: nil), forCellReuseIdentifier: "RepoIntroCell");
        tableView.registerNib(UINib(nibName: "RepoInfoCell", bundle: nil), forCellReuseIdentifier: "RepoInfoCell");
        
        tableView.estimatedRowHeight = 200 //预先估计
        tableView.rowHeight = UITableViewAutomaticDimension //自动适应
    }

    
    func fetchBranches() {
        Provider.shareProvider.request(GithubAPI.RepoBranches(owner: repoInfo!.owner!.login!, repo: repoInfo!.name!))
        { (result) in
            switch result{
            case let .Success(response):
                do{
//                    let json = try response.mapString()
//                    print(json)
                    
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Branches>() //2.使用model构建解析器
                    self.branches = mapper.mapArray(json)!  //3.解析并返回对象
                    
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

extension RepoInfoViewController: UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        default:
            return 2
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoIntroCell") as? RepoIntroCell
            cell?.repoinfo = repoInfo
            return cell!
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoInfoCell") as? RepoInfoCell
            switch indexPath.row {
            case 0:
                 cell?.customUI(UIImage(named: "octicon_person_25")!, actionName: "成员")
            case 1:
                cell?.customUI(UIImage(named: "coticon_branch_25")!, actionName: "分支")
            case 2:
                cell?.customUI(UIImage(named: "octicon_commit_25")!, actionName: "动态")
            default:
                  return cell!
            }
            return cell!
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoInfoCell") as? RepoInfoCell
            
            switch indexPath.row {
            case 0:
                cell?.customUI(UIImage(named: "octicon_pull_request_25")!, actionName: "合并请求")
            case 1:
                cell?.customUI(UIImage(named: "octicon_watch_red_25")!, actionName: "README")
            default:
                return cell!
            }
            return cell!
        }
    }
    
}

extension RepoInfoViewController: UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = (indexPath.section, indexPath.row)
        switch index {
            
        case (1,0):
            print("成员")
            let developerListVC = DeveloperListViewController()
            developerListVC.title = "成员列表"
//            developerListVC.developer = repoInfo?.owner
            if let nav = self.parentViewController?.navigationController {
                nav.pushViewController(developerListVC, animated: true)
            }else{
                self.navigationController?.pushViewController(developerListVC, animated: true)
            }
            
        case (1,1):
            print("分支")
             showBranches()
            
        case (1,2):
            print("动态")
            
        case (2,0):
            print("合并请求")
//            let prvc = PRListViewController()
//            prvc.repoinfo = repoInfo
//            self.navigationController?.pushViewController(prvc, animated: true)
            
        case (2,1):
            print("readMe")
//            let readmeVC = ReadmeViewController()
//            readmeVC.repo = repoInfo
//            navigationController?.pushViewController(readmeVC, animated: true)
            
        default:
            print("未定义")
        }
    }
    
    func showBranches() {
        if branches == nil {
            return
        }
        
//        let title:[String] = branches!.map { (branch:Branches) -> String in
//            return branch.name!
//        }
        var title = [String]()
        for (_, element) in (branches?.enumerate())! {
            title.append(element.name!)
        }
        
        
        let sheet = JWSheet.init(frame: view.frame, items: title) { (index) in
            print(index)
        }
        tabBarController!.view.addSubview(sheet)
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        if section == 0{
            return 0.00001
        }
        return 10
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.1
    }
}











