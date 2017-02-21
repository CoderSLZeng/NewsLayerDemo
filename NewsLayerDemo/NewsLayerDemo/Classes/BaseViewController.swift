//
//  BaseViewController.swift
//  NewsLayerDemo
//
//  Created by Anthony on 17/2/21.
//  Copyright © 2017年 SLZeng. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    
    //==========================================================================================================
    // MARK: - 自定义属性
    //==========================================================================================================
    /// 屏幕的宽度
    let kScreenW = UIScreen.mainScreen().bounds.width
    /// 屏幕的高度
    let kScreenH = UIScreen.mainScreen().bounds.height
    
    /// 标题栏
    let titleScorllView = UIScrollView()
    
    /// 视图容器
    let contentScrollView = UIScrollView()
    
    
    //==========================================================================================================
    // MARK: - 系统方法
    //==========================================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.导航条标题
        self.navigationItem.title = "网易新闻"
        
        // 2.取消自动调整内边距
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        
        // 3.标题栏
        setupTitleScrollView()
        
        // 4.视图容器
        setupContentScrollView()
        
        // 5.添加所有子控制器
        addAllChildVC()
        
        // 6.设置所有标题文字
        setupAllTitle()
    }
    
    //==========================================================================================================
    // MARK: - 初始化方法
    //==========================================================================================================
    /**
     设置标题栏
     */
    func setupTitleScrollView() {
        let y = ((self.navigationController?.navigationBarHidden) != nil) ? 64 : 20
        titleScorllView.frame = CGRect(x: 0, y: y, width: Int(kScreenW), height: 44)
        view.addSubview(titleScorllView)
        
        titleScorllView.showsHorizontalScrollIndicator = false
    }
    
    /**
     设置视图容器
     */
    func setupContentScrollView() {
        let height = kScreenH - titleScorllView.bounds.height
        contentScrollView.frame = CGRect(x: 0, y: CGRectGetMaxY(titleScorllView.frame), width: kScreenW, height: height)
        view.addSubview(contentScrollView)
        
        contentScrollView.backgroundColor = UIColor.blueColor()
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
    
    /**
     添加子控制器和标题
     
     - parameter childController: 子控制器
     - parameter title:           标题
     */
    func addChildViewController(childController: UIViewController, title: String) {
        childController.title = title
        self.addChildViewController(childController)
    }
    
    /**
     设置所有标题文字
     */
    func setupAllTitle() {
        
        let count = self.childViewControllers.count
        
        var titleBtnW = 100
        // 获取标题栏的宽度
        let titleSVContentSizeW = CGFloat(count * titleBtnW)
        // 判断
        if  titleSVContentSizeW < kScreenW {
            titleBtnW = Int(kScreenW) / count
        }
        
        // 创建按钮
        for i in 0..<count {
            let titleBtn = UIButton()
            let titleBtnX = i * titleBtnW
            titleBtn.frame = CGRect(x: titleBtnX, y: 0, width: titleBtnW, height: Int(titleScorllView.bounds.height))
            titleScorllView.addSubview(titleBtn)
            
            // 设置标题文字
            let vc = self.childViewControllers[i]
            titleBtn.setTitle(vc.title, forState: UIControlState.Normal)
            titleBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        }
        
        // 设置标题栏内容尺寸
        titleScorllView.contentSize = CGSize(width: titleSVContentSizeW, height: 0)
    }

}

