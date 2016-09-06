//
//  BaseViewController.swift
//  YZGithubClient
//
//  Created by 张凯 on 16/8/16.
//  Copyright © 2016年 Zheng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var leftItem:UIButton?
    
    var leftItemImage:UIImage?{
        didSet{
            leftItem!.setImage(leftItemImage, forState: .Normal)
        }
    }
    var leftItemSelImage:UIImage?{
        didSet{
            leftItem!.setImage(leftItemSelImage, forState: .Selected)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customLeftItem()
    }
    
    func customLeftItem() {
        
        leftItem = UIButton()
        leftItem!.setImage(UIImage(named: "arrow_left"), forState: .Normal)
        leftItem!.setImage(UIImage(named: "arrow_left"), forState: .Selected)
        
        leftItem!.frame = CGRectMake(0, 5, 25, 25)
        leftItem!.addTarget(self, action: #selector(self.leftItemAction(_:)), forControlEvents: .TouchUpInside)
        leftItem!.hidden = false
        
        let leftBarButton = UIBarButtonItem.init(customView: leftItem!)
        let leftSpace = UIBarButtonItem.init(barButtonSystemItem: .FixedSpace, target: nil, action: nil)
        leftSpace.width = -8;      //越小越靠左
        
        self.navigationItem.leftBarButtonItems = [leftSpace,leftBarButton]
        
    }
    func leftItemAction(sender:UIButton?) {
        
    }
}
