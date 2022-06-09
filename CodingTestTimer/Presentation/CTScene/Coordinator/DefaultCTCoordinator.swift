//
//  DefaultCTCoordinator.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/09.
//

import UIKit

final class DefaultCTCoordinator: CTCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .codingTest
    
    func start() {
        
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func pushCTViewController(with settingData: CTSetting) {
        let ctViewController = CTViewController()
        ctViewController.viewModel = CTViewModel(coordinator: self, ctUseCase: DefaultCTUseCase(ctSetting: settingData))
        
        self.navigationController.pushViewController(ctViewController, animated: true)
    }
}
