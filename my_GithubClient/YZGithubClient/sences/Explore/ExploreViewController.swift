//
//  ExploreViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/15.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class ExploreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let reposVC = ExploreReposViewController()
        let tableView = reposVC.tableView
        tableView.frame = view.bounds
        view.addSubview(tableView)
        self.addChildViewController(reposVC)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
