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
        titleScorllView.backgroundColor = UIColor.grayColor()
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

}

