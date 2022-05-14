//
//  ViewController.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/11.
//

import UIKit

class RootTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .dark
        
        tabBar.tintColor = .label
        tabBar.backgroundColor = .tabBar
        
        let codingTestTab = CodingTestViewController(title: "테스트", bgColor: UIColor.background!)
        let historyTab = UINavigationController(rootViewController: HistoryViewController(title: "기록", bgColor: UIColor.white))
        
        let codingTestTabBarItem = UITabBarItem(title: "테스트", image: UIImage(systemName: "clock"), tag: 0)
        let historyTabBarItem = UITabBarItem(title: "기록", image: UIImage(systemName: "tray"), tag: 1)
        
        codingTestTab.tabBarItem = codingTestTabBarItem
        historyTab.tabBarItem = historyTabBarItem
        
        setViewControllers([codingTestTab, historyTab], animated: false)
    }
}

