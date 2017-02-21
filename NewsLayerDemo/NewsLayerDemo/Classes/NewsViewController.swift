//
//  NewsViewController.swift
//  NewsLayerDemo
//
//  Created by Anthony on 17/2/21.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

import UIKit

class NewsViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.导航条标题
        self.navigationItem.title = "网易新闻"
        // 2.添加所有子控制器
        addAllChildVC()
        
    }

    /**
     添加所有子控制器
     */
    func addAllChildVC()  {
        // 头条
        addChildViewController(HeaderLineViewController(), title: "头条")
        
        // 热点
        addChildViewController(HotPointViewController(), title: "热点")
        
        // 视频
        addChildViewController(VideoViewController(), title: "视频")
        
        // 社会
        addChildViewController(SocietyViewController(), title: "社会")
        
        // 科技
        addChildViewController(ScienceViewController(), title: "科技")
        
        // 订阅
        addChildViewController(SubscriptionViewController(), title: "订阅")
    }
}
