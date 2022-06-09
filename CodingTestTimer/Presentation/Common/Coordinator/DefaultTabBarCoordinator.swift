//
//  DefaultTabBarCoordinator.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import UIKit

final class DefaultTabBarCoordinator: TabBarCoorinator {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = [Coordinator]()
    var type: CoordinatorType { .tab }
    var tabBarController: UITabBarController
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = UITabBarController()
    }
    
    func start() {
        let pages: [TabBarPage] = TabBarPage.allCases
        let controllers: [UINavigationController] = pages.map({
            self.createTabNavigationController(of: $0)
        })
        self.configureTabBarController(with: controllers)
    }
    
    func configureTabBarController(with tabViewControllers: [UIViewController]) {
        self.tabBarController.setViewControllers(tabViewControllers, animated: true)
        self.tabBarController.selectedIndex = TabBarPage.codingTest.pageOrderNumber()
        self.tabBarController.view.backgroundColor = .background
        self.tabBarController.tabBar.backgroundColor = .tabBar
        self.tabBarController.tabBar.tintColor = .white
        
        self.navigationController.pushViewController(self.tabBarController, animated: true)
    }
    
    private func configureTabBarItem(of page: TabBarPage) -> UITabBarItem {
        return UITabBarItem (
            title: nil,
            image: UIImage(systemName: "flame"),
            tag: page.pageOrderNumber()
        )
    }
    
    private func createTabNavigationController(of page: TabBarPage) -> UINavigationController {
        let tabNavigationController = UINavigationController()
        
        tabNavigationController.setNavigationBarHidden(false, animated: false)
        tabNavigationController.tabBarItem = self.configureTabBarItem(of: page)
        self.startTabCoordinator(of: page, to: tabNavigationController)
        return tabNavigationController
        
    }
    
    private func startTabCoordinator(of page: TabBarPage, to tabNavigationController: UINavigationController) {
        switch page {
        case .codingTest:
            let ctHomeCoordinator = DefaultCTHomeCoordinator(tabNavigationController)
            ctHomeCoordinator.finishDelegate = self
            self.childCoordinators.append(ctHomeCoordinator)
            ctHomeCoordinator.start()
        
        case .history:
            let historyCoordinator = DefaultHistoryCoordinator(tabNavigationController)
            historyCoordinator.finishDelegate = self
            self.childCoordinators.append(historyCoordinator)
            historyCoordinator.start()
        }
    }
}

extension DefaultTabBarCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
    }
}

