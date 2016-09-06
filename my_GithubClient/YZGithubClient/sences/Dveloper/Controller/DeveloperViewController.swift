//
//  DeveloperViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/12.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper

class DeveloperViewController: UIViewController {
    
    var developer:Developer? {
        didSet{
            title = developer?.login
        }
    }
    
    let tableView:UITableView = UITableView(frame:CGRectZero, style:.Grouped)
    var headerImageView:UIImageView? // 顶部可拉伸背景
    var userImageView : UIImageView? //头像
    var loginLabel : UILabel? //用户名
    var followersLable:UILabel?  //粉丝
    var startLable:UILabel?// 关注
    
    var width:CGFloat? {
        return UIScreen.mainScreen().bounds.size.width
    }
    var height:CGFloat = 200

    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customUI()
        fetchUserInfo()
    }
    
    
    func customUI (){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self.view)
            make.size.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        tableView.registerNib(UINib(nibName:"UserBaseInfoCell", bundle: nil), forCellReuseIdentifier: "UserBaseInfoCell")
        tableView.registerNib(UINib(nibName:"RepoInfoCell", bundle: nil), forCellReuseIdentifier: "RepoInfoCell")
        tableView.estimatedRowHeight = 100  //推测
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //背景
        headerImageView = UIImageView(image:UIImage(named: "profile_bk"))
        headerImageView?.contentMode = .ScaleAspectFill
        headerImageView?.frame = CGRectMake(0, -height, width!, height)
        tableView.addSubview(headerImageView!)
        tableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0)
        
        //头像
        userImageView = UIImageView(image:UIImage(named:"app_logo_90"))
        headerImageView!.addSubview(userImageView!)
        userImageView!.snp_makeConstraints { (make) in
            make.centerX.equalTo(headerImageView!)
            make.centerY.equalTo(headerImageView!)
            make.width.height.equalTo(headerImageView!.snp_width).multipliedBy(0.2) //宽度的0.3倍
        }
        userImageView!.layoutIfNeeded() //获取真实的Frame
        userImageView!.layer.cornerRadius = userImageView!.frame.size.width/2;
        userImageView!.layer.masksToBounds = true
        
        //用户名
        loginLabel = UILabel()
        loginLabel!.text = "开发者"
        loginLabel!.textAlignment = .Center
        loginLabel?.font = UIFont.systemFontOfSize(14)
        loginLabel?.textColor = UIColor.whiteColor()
        headerImageView!.addSubview(loginLabel!)
        loginLabel!.snp_makeConstraints { (make) in
            make.centerX.equalTo(headerImageView!)
            make.top.equalTo(userImageView!.snp_bottom).offset(10);
        }
        
        //粉丝和关注的人
        followersLable = UILabel()
        followersLable?.text = "  人关注"
        followersLable!.textColor = UIColor.whiteColor()
        followersLable!.font = UIFont.systemFontOfSize(13)
        headerImageView!.addSubview(followersLable!)
        followersLable!.snp_makeConstraints { (make) in
            make.right.equalTo((loginLabel?.snp_centerX)!).offset(-10)
            make.top.equalTo((loginLabel?.snp_bottom)!).offset(10)
        }
        
        startLable = UILabel()
        startLable?.text = "关注  人"
        startLable!.textColor = UIColor.whiteColor()
        startLable!.font = UIFont.systemFontOfSize(13)
        headerImageView!.addSubview(startLable!)
        startLable!.snp_makeConstraints { (make) in
            make.left.equalTo((loginLabel?.snp_centerX)!).offset(10)
            make.top.equalTo(followersLable!)
        }
    }

    func refreshUI(){
        if developer != nil {
            if let url = developer?.avatar_url {
                userImageView?.kf_setImageWithURL(NSURL(string: url)!)
            }
            if let login = developer?.login {
                loginLabel?.text = login
            }
            if let followers = developer?.followers{
                followersLable?.text = "\(followers) 人关注"
            }
            if let following = developer!.following{
                startLable?.text = "关注\(following)人"
            }
        }
    }
    
    
    //MARK: 用户数据请求
    func fetchUserInfo() {
        let provider = Provider.shareProvider
        provider.request(GithubAPI.UserInfo(username: (developer?.login)!)) { (result) in
            switch result{
            case let .Success(response):
                //Response Moya框架的
                do{
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Developer>() //2.使用model构建解析器
                    self.developer = mapper.map(json) //3.解析并返回对象
                    
                    self.tableView .reloadData()
                    self.refreshUI()
                    
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


extension DeveloperViewController:UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case 0:
            return 3
        case 1:
            return 1
        default:
            return 1
        }
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier("UserBaseInfoCell") as? UserBaseInfoCell
            switch indexPath.row {
            case 0:
                cell?.customUI(name: "地址", value: developer?.location ?? "他没有写")
                return cell!
            case 1:
                cell?.customUI(name: "公司", value: developer?.company ?? "他没有写")
                return cell!
            default:
                cell?.customUI(name: "简介", value: developer?.bio ?? "他没有写")
                return cell!
            }
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoInfoCell") as? RepoInfoCell
            cell?.customUI(UIImage(named: "octicon_person_25")!, actionName: "详细资料")
            return cell!
            
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoInfoCell") as? RepoInfoCell
            cell?.customUI(UIImage(named: "coticon_repository_25")!, actionName: "仓库")
            return cell!
        }
    }

}

extension DeveloperViewController:UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = (indexPath.section, indexPath.row)
        switch index {
        case (2,0):
            print("跳转到开发者的仓库列表")
            let repoList = RepoListViewController()
            repoList.developer = developer
            navigationController?.pushViewController(repoList, animated: true)
        default:
            print("仅仓库按钮实现")
        }
        
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 10
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 1
    }
    
    
    //滑动结束触发
    func scrollViewDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offset = abs(scrollView.contentOffset.y)
        if offset >= 164 {
            var frame = headerImageView?.frame
            frame?.size.height = offset - 64
            frame?.origin.y = -(offset - 64)
            headerImageView?.frame = frame!
        }
    }

}

