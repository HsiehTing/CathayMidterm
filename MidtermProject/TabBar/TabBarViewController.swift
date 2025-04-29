//
//  TabBarViewController.swift
//  MidtermProject
//
//  Created by TWINB00599242 on 2025/4/29.
//

import UIKit

open class TabBarViewController: UITabBarController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpViewController()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.selectedIndex = 1
    }
    
    func setUpViewController() {
        let newsVC = newsPageViewController()
        let newsVCItem = UITabBarItem(title: "新聞", image: UIImage(systemName: "bell.fill"), tag: 0)
        newsVC.tabBarItem = newsVCItem
        
        let homeVC = HomePageViewController()
        let homeVCItem = UITabBarItem(title: "首頁", image: UIImage(systemName: "house.fill"), tag: 1)
        homeVC.tabBarItem = homeVCItem

        let settingVC = settingPageViewController()
        let settingVCItem = UITabBarItem(title: "設定", image: UIImage(systemName: "gear"), tag: 2)
        settingVC.tabBarItem = settingVCItem
        
        let controllers = [newsVC, homeVC, settingVC]
        self.viewControllers = controllers
    }
    
}
