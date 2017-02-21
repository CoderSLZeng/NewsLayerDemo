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
    // MARK: - 懒加载
    //==========================================================================================================
    /// 默认选中的按钮
    lazy var selectedButton = UIButton()
    
    lazy var titleButtons = [UIButton]()
    
    //==========================================================================================================
    // MARK: - 系统方法
    //==========================================================================================================

    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.导航条标题
        self.navigationItem.title = "网易新闻"
        
        // 2.取消自动调整内边距
        self.automaticallyAdjustsScrollViewInsets = false
        
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
        
        // 设置视图容器的属性
        // 代理
        contentScrollView.delegate = self
        // 分页
        contentScrollView.pagingEnabled = true
        // 取消弹簧效果
        contentScrollView.bounces = false

        
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
            
            // 添加按钮监听事件
            titleBtn.tag = i
            titleBtn.addTarget(self, action: #selector(BaseViewController.titleButtonClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            
            // 默认选中第一个按钮
            if 0 == i
            {
                titleButtonClick(titleBtn)
            }
            
            // 添加按钮到数值中
            titleButtons.append(titleBtn)
        }
        
        // 设置标题栏内容尺寸
        titleScorllView.contentSize = CGSize(width: titleSVContentSizeW, height: 0)
        contentScrollView.contentSize = CGSize(width: Int(kScreenW) * count, height: 0)
    }
    
    //==========================================================================================================
    // MARK: - 处理监听事件
    //==========================================================================================================
    
    /**
     监听按钮点击事件
     
     - parameter button: 被点击的按钮
     */
    func titleButtonClick(button: UIButton) {
        
        selectedTitleButton(button)
        
        let index = button.tag
        showViewController(index)
        
        contentScrollView.contentOffset = CGPoint(x: index * Int(kScreenW), y: 0)
    }
    
    //==========================================================================================================
    // MARK: - 自定义方法
    //==========================================================================================================
    
    /**
     选中标题按钮
     
     - parameter button: 被选中的标题按钮
     */
    func selectedTitleButton(button: UIButton) {
        // 默认缩放比例
        let scale: CGFloat = 1.3
        // 取消之前按钮缩放
        selectedButton.transform = CGAffineTransformIdentity
        selectedButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        button.transform = CGAffineTransformMakeScale(scale, scale)
        selectedButton = button
        
        // 设置按钮标题居中
        setupTitleCenter(button)
    }
    
    /**
     设置按钮标题居中
     
     - parameter button: 按钮
     */
    func setupTitleCenter(button: UIButton) {
        // 本质修改标题栏的偏移量
        var offsetX = button.center.x - kScreenW * 0.5
        
        // 判断offsetX越界的处理
        if offsetX < 0
        {
            offsetX = 0
        }
        
        let maxOffsetX = self.titleScorllView.contentSize.width - kScreenW
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        
        self.titleScorllView.setContentOffset(CGPoint(x: offsetX, y:0), animated: true)
    }
    
    /**
     显示控制器
     
     - parameter index: 子控制器的下标
     */
    func showViewController(index: Int) {
        let vc = self.childViewControllers[index]
        
        // 判断控制器的视图是否加载
        if vc.isViewLoaded() {
            return
        }
        
        vc.view.frame = CGRect(x: CGFloat(index) * kScreenW, y: 0, width: kScreenW, height: contentScrollView.bounds.height)
        contentScrollView.addSubview(vc.view)
    }

}

// MARK: - UIScrollViewDelegate
extension BaseViewController: UIScrollViewDelegate
{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        // 获取当前页码
        let index = Int(scrollView.contentOffset.x / kScreenW)
        // 获取按钮
        let button = titleButtons[index]
        // 点击获取的按钮
        titleButtonClick(button)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        // 获取当前页码
        let index = Int(scrollView.contentOffset.x / kScreenW)
        // 获取左边的按钮
        let LeftBtn = self.titleButtons[index]
        
        // 获取右边的按钮
        var rightBtn = UIButton()
        let indexR = index + 1
        let count = self.titleButtons.count
        if indexR < count  {
            rightBtn = self.titleButtons[Int(indexR)]
        }
        
        // 计算缩放比例
        let scale = scrollView.contentOffset.x / kScreenW
        let scaleR = scale -  CGFloat(index)
        let scaleL = 1 - scaleR
        
        // 设置按钮形变
        LeftBtn.transform = CGAffineTransformMakeScale(scaleL * 0.3 + 1, scaleL * 0.3 + 1)
        rightBtn.transform = CGAffineTransformMakeScale(scaleR * 0.3 + 1, scaleR * 0.3 + 1)
        
        // 标题文字颜色渐变
        let colorL = UIColor(red: scaleL, green: 0, blue: 0, alpha: 1.0)
        let colorR = UIColor(red: scaleR, green: 0, blue: 0, alpha: 1.0)
        
        LeftBtn.setTitleColor(colorL, forState: UIControlState.Normal)
        rightBtn.setTitleColor(colorR, forState: UIControlState.Normal)
        
        
    }
}

