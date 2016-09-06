//
//  ProfileViewController.swift
//  YZGithubClient
//
//  Created by 郑建文 on 16/8/9.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper
import Kingfisher

class ProfileViewController: UIViewController,UMSocialUIDelegate{
    var myInfo:Developer? { //用户信息
        didSet{
//             myInfo = Developer().loadDeveloper()
             self.updateUserinfoData() //更新UI
        }
    }
 
    let tableView:UITableView = UITableView(frame: CGRectZero, style: .Grouped)
    var headerImageView:UIImageView? { // 顶部可拉伸背景
        return tableView.viewWithTag(101) as? UIImageView
    }
    
    var profileImageView : UIImageView? //头像
    var loginLabel : UILabel? //登录
    var followersLable:UILabel = UILabel() //专注
    var startLable:UILabel = UILabel() // 星
    
    var width:CGFloat? {
        return UIScreen.mainScreen().bounds.size.width
    }
    var height:CGFloat = 200

    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //登陆成功
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileViewController.fetchUserInfo), name: Github_loginSuccess, object: nil);
        //注销成功
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ProfileViewController.deleteMyInfo), name: Github_logoutSuccess, object: nil);
        
        
        customUI()
        fetchUserInfo()
    }
    
    func customUI(){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.top.left.equalTo(self.view)
            make.size.equalTo(self.view)
        }
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "settingCell")

        customHeader()
    }
    
    func customHeader() {
        //背景
        let imageView = UIImageView(image: UIImage(named: "profile_bk"))
        imageView.contentMode = .ScaleAspectFill
        imageView.frame = CGRectMake(0, -height, width!, height)
        imageView.tag = 101
        //确保 图片能够覆盖imageview
        //        imageView.contentMode = .ScaleToFill
        //确保图片能够显示完全
        //        imageView.contentMode = .ScaleAspectFit
        //图片会等比放大,填充imageview
        
        imageView.userInteractionEnabled = true
        tableView.addSubview(imageView)
        tableView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0)
        
       //头像
        profileImageView = UIImageView(image:UIImage(named:"app_logo_90"))
        imageView.addSubview(profileImageView!)
        profileImageView!.snp_makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.centerY.equalTo(imageView)
            make.width.height.equalTo(headerImageView!.snp_width).multipliedBy(0.2) //宽度的0.3倍
        }
        profileImageView!.layoutIfNeeded() //获取真实的Frame
        profileImageView!.layer.cornerRadius = profileImageView!.frame.size.width/2;
        profileImageView!.layer.masksToBounds = true
      

        //登陆
        loginLabel = UILabel()
        loginLabel!.text = "登陆"
        loginLabel!.textAlignment = .Center
        loginLabel?.font = UIFont.systemFontOfSize(14)
        loginLabel?.textColor = UIColor.whiteColor()
        imageView.addSubview(loginLabel!)
        loginLabel!.snp_makeConstraints { (make) in
            make.centerX.equalTo(imageView)
            make.top.equalTo(profileImageView!.snp_bottom).offset(10);
        }
        
        loginLabel!.userInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target:self, action:#selector(ProfileViewController.login))
        loginLabel!.addGestureRecognizer(tap)
        
        //粉丝和关注的人
        imageView.addSubview(followersLable)
        followersLable.textColor = UIColor.whiteColor()
        followersLable.font = UIFont.systemFontOfSize(13)
        followersLable.snp_makeConstraints { (make) in
            make.right.equalTo((loginLabel?.snp_centerX)!).offset(-10)
            make.top.equalTo((loginLabel?.snp_bottom)!).offset(10)
        }
        
        imageView.addSubview(startLable)
        startLable.textColor = UIColor.whiteColor()
        startLable.font = UIFont.systemFontOfSize(13)
        startLable.snp_makeConstraints { (make) in
            make.left.equalTo((loginLabel?.snp_centerX)!).offset(10)
            make.top.equalTo(followersLable)
        }
    }
    
    //MARK: 用户数据请求
    func fetchUserInfo() {
        let provider = Provider.shareProvider
        provider.request(GithubAPI.MyInfo) { (result) in
            switch result{
            case let .Success(response):
                //Response Moya框架的
                do{
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Developer>() //2.使用model构建解析器
                     self.myInfo = mapper.map(json) //3.解析并返回对象
//                    print(developer?.name)
                    
                     //对象归档
                     self.myInfo!.saveDeveloper()
                    
//                    print(NSHomeDirectory()) //打印沙盒地址
                }catch{
                    print("JSON 解析失败")
                }
                print("网络请求成功")
                
            case let .Failure(error):
                print("网络请求失败")
            }
        }
    }
    
    //删除个人信息
    func deleteMyInfo(){
        self.myInfo = nil;
        self.view.hudMessage("退出登陆")
    }
    
    //MARK: 登陆action
    func login(){
        let loginVC = LoginViewController()
        
        //client_id 这个app 申请的github app id
        // redirect_url 回调页面
        //scope 可以访问的模块
        let url = "https://github.com/login/oauth/authorize/?client_id=\(GithubClient_id)&redirect_uri=\(redirect_uri)&scope=user,user:email,user:follow,public_repo,repo,repo_deployment,repo:status,delete_repo,notifications,gist,read:repo_hook,write:repo_hook,admin:repo_hook,admin:org_hook,read:org,write:org,admin:org,read:public_key,write:public_key,admin:public_key"
        loginVC.url = url
        
        self.navigationController?.pushViewController(loginVC, animated: true)
    }
    
    
    //MARK: 更新UI
    func updateUserinfoData() {
        
        if myInfo != nil {
            if let url = myInfo!.avatar_url {
                profileImageView!.kf_setImageWithURL(NSURL(string: url)!)
            }
            if let name = myInfo!.name {
                 loginLabel?.text = name
            }
            if let followers = myInfo!.followers{
                followersLable.text = "\(followers) 人关注"
            }
            if let following = myInfo!.following{
                 startLable.text = "关注\(following)人"
            }

        }else {
            profileImageView = UIImageView(image:UIImage(named:"app_logo_90"))
            loginLabel?.text = "登陆"
            followersLable.text = ""
            startLable.text = ""
        }
        
    }
    
}



extension ProfileViewController:UITableViewDataSource {

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath)
        
        let index = (indexPath.section, indexPath.row)
        
        switch index {
        case (0,0):
            cell.textLabel?.text = "关注"
        case (1,0):
            cell.textLabel?.text = "设置"
        default:
            cell.textLabel?.text = "分享"
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let index = (indexPath.section,indexPath.row)
        switch index {
        case (0,0):
             print("跳转关注")
            let follewVC = DeveloperListViewController()
            follewVC.title = "关注列表"
            follewVC.target = GithubAPI.MyFollower
            self.navigationController?.pushViewController(follewVC, animated: true)
            
        case (1,0):
             print("跳转设置")
             let settingVC = SettingViewController()
             self.navigationController?.pushViewController(settingVC, animated: true)

        default:
            print("分享")
            share()
        }
    }

    
    func share(){
        UMSocialSnsService.presentSnsIconSheetView(self, appKey: "56025946e0f55a744000439c", shareText: "加入我们吧!", shareImage: UIImage(named: "app_logo_90"), shareToSnsNames: [UMShareToSina], delegate: self)
    }
    
    
}


extension ProfileViewController:UITableViewDelegate{
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat{
        return 20
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 0.01
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




