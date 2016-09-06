//
//  SearchReposViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/16.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit
import SnapKit
import ObjectMapper
import MBProgressHUD

class SearchReposViewController: UIViewController {
    var reposArray = [Repository]() //仓库数组
    
    var currentPage:NSInteger = 1 //要请求的页数
    var isLastPage = false        //是否是最后一页了
    
    let searchBar = UISearchBar(frame:CGRectMake(20, 0, 280, 0))
    let tableView = UITableView(frame:CGRectZero, style:.Plain)

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        customSearchBar()
        customTableView()
    }
    
    func customSearchBar(){
        searchBar.delegate = self
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.placeholder = "仓库信息"
//        searchBar.barStyle = UIBarStyle.BlackTranslucent
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 5.0
        
        navigationItem.rightBarButtonItem  = UIBarButtonItem(customView:searchBar)
    }
    
    func customTableView(){
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.size.equalTo(self.view)
            make.top.left.equalTo(self.view)
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellReuseIdentifier")
        tableView.registerNib(UINib(nibName: "RepoTableViewCell", bundle: nil), forCellReuseIdentifier: "RepoTableViewCell")

        tableView.estimatedRowHeight = 100  //推测
        tableView.rowHeight = UITableViewAutomaticDimension //Cell高度自适应
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension SearchReposViewController :UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.reposArray.count > 0 {
             return self.reposArray.count + 1
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == self.reposArray.count{
            let cell = tableView.dequeueReusableCellWithIdentifier("cellReuseIdentifier")

            if isLastPage {
                cell?.textLabel?.text = "没有数据了"
            }else{
                cell?.textLabel?.text = "加载更多"
            }

            cell?.textLabel?.textAlignment = .Center
            return cell!
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("RepoTableViewCell") as? RepoTableViewCell
            
            cell?.repo = self.reposArray[indexPath.row]
            return cell!
        } 
    }
}

extension SearchReposViewController :UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.reposArray.count {
            if isLastPage {
                
            } else {
                print("下拉 继续加载 ")
                self.feachData()
            }
        }else{
            print("仓库 详细")
            let repoInfoVC = RepoInfoViewController()
            repoInfoVC.repoInfo = self.reposArray[indexPath.row]
            navigationController?.pushViewController(repoInfoVC, animated: true)
        }
    }
}

extension SearchReposViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.reposArray.removeAll()
        currentPage = 1
        feachData()
    }
    
    func feachData(){
        let hud = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        hud.labelText = "搜索中..."
        
        let provider = Provider.shareProvider
        provider.request(GithubAPI.SearchReposWithKeyWord(keyword: searchBar.text!, page: currentPage)) {
            (result) in
            switch result {
            case let .Success(response):
                do {
                    //读取reponse 中是否有link
                    let httpresponse = response.response as? NSHTTPURLResponse
                    let link = httpresponse?.allHeaderFields["Link"]
                    if let _ = link {
                        self.isLastPage = false
                    }else {   //响应头中没有link -> 当前页面就是最后一页了
                        self.isLastPage = true
                    }
                    
                    
                    let json = try response.mapJSON()
                    
                    //解析Json为对象                    //1.model 实现协议
                    let mapper = Mapper<Repository>() //2.使用model构建解析器
                    let array = mapper.mapArray(json["items"])  //3.解析并返回对象
                    
                    self.reposArray += array! //追加新数据
                    self.currentPage += 1     //页数加1
                    
                    self.tableView .reloadData()
                    MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                } catch{
                     self.view.hudError("数据解析失败")
                }
            case let .Failure(error):
                self.view.hudError("网络请求失败:\(error)")
            }
            
        }
    }

}


