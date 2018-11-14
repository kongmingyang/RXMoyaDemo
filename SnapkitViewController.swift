//
//  SnapkitViewController.swift
//  SwiftDemo
//
//  Created by 55it on 2018/11/3.
//  Copyright © 2018年 55it. All rights reserved.
//

import UIKit
import SnapKit
class SnapkitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       self.navigationItem.title = "SnapKit练习"
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        view.addSubview(scrollView)
        
         let view1  = UIView.init()
         view1.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
         scrollView.addSubview(view1)
        
        let view2 = UIView.init()
        view2.backgroundColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        scrollView.addSubview(view2)
        
        let view3 = UIView.init()
        view3.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        scrollView.addSubview(view3)
        
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
        view1.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
        view2.snp.makeConstraints { (make) in
            
            make.top.equalTo(view1.snp.bottom).offset(200)
            make.left.equalTo(view1.snp.right).offset(50)
            make.width.height.equalTo(300)
            make.right.equalTo(scrollView)
            
        }
        view3.snp.makeConstraints { (make) in
            make.left.equalTo(100)
            make.top.equalTo(view2.snp.bottom).offset(200)
            make.width.height.equalTo(300)
            make.bottom.equalTo(scrollView)
        }
        
        
        
        
        
        
        
    }

  
}
