//
//  ExploreReposViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/15.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import ObjectMapper
import MBProgressHUD

//展示所有仓库， 分页获取
class ExploreReposViewController: BaseViewController {
    var reposArray = [Repository]() //仓库数组
    var lastSince:NSInteger = 0  //记录请求数据最后一个仓库的ID 初始为0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftItemImage = UIImage(named: "nav_search_35")
        title = "搜索"
        
        view.addSubview(self.tableView)
        fetchData()
    }
    override func leftItemAction(sender:UIButton?) {
        super.leftItemAction(sender);
        print("跳转到搜索界面")
        
        let searchReposVC = SearchReposViewController()
        navigationController?.pushViewController(searchReposVC, animated: true)
    }
    
    
    //获取网络数据
    func fetchData (){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "开始加载"
        
        let provider = Provider.shareProvider
        provider.request(GithubAPI.AllRposSince(since: lastSince)) { (result) in
            switch result{
            case let .Success(response): //Response
                do{
                    //NSURLResponse的子类: NSHTTPURLResponse
                    let httpURLResponse = response.response as? NSHTTPURLResponse
                    if let res = httpURLResponse {
                        //取到http 协议头的中的link 参数
                        let link = res.allHeaderFields["Link"]
                        
                        if let link = link {
                            let since = self.getLastSince(link as! String) //截取since
                            if let since = since{
                                self.lastSince = since
                            }
                        }
                    }
                    
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Repository>() //2.使用model构建解析器
                    let array = mapper.mapArray(json)!  //3.解析并返回对象
    
                    self.reposArray += array;
                    self.tableView .reloadData()
                    
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
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
    }
    
    // MARK: 布局tableview
    // 闭包创建tableView  懒加载
    lazy var tableView:UITableView = {
        let tableView = UITableView(frame:self.view.bounds, style:UITableViewStyle.Plain)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.registerNib(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")
        
        tableView.estimatedRowHeight = 100  //推测
        tableView.rowHeight = UITableViewAutomaticDimension //Cell高度自适应
        
        return tableView
    }()
    
    // 截取since
    //<https://api.github.com/repositories?since=367>; rel="next", <https://api.github.com/repositories{?since}>; rel="first",
    func getLastSince(link:String) -> Int? {
        var since:Int?
        let linkArray = link.componentsSeparatedByString(",")
        for rel in linkArray{
            if rel.containsString("next"){
                let startIndex = rel.rangeOfString("since=")?.endIndex
                let endIndex = rel.rangeOfString(">;")?.startIndex
                since = Int(rel.substringWithRange(startIndex! ..< endIndex!))
            }
        }
        return since
    }
    
}

extension ExploreReposViewController : UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.reposArray.count + 1
    }
   
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        if indexPath.row == self.reposArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("cellReuseIdentifier")
            cell?.textLabel?.text = "点击加载更多"
            cell?.textLabel?.textAlignment = .Center
            
            return cell!
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoTableViewCell") as? RepoTableViewCell
            cell?.repo = self.reposArray[indexPath.row]
            return cell!
        }
    }
}

extension ExploreReposViewController : UITableViewDelegate{
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == self.reposArray.count {
            print("下拉 继续加载 ")
            self.fetchData()
        }else{
            print("仓库 详细")
            let repoInfoVC = RepoInfoViewController()
            repoInfoVC.repoInfo = self.reposArray[indexPath.row]
            navigationController?.pushViewController(repoInfoVC, animated: true)
        }
    }
    
}










