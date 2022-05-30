//
//  DefaultCTSettingCoordinator.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import UIKit

final class DefaultCTSettingCoordinator: CTSettingCoordinator {
    
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var ctSettingViewController: CTSettingViewController
    var type: CoordinatorType = .setting
    var childCoordinators: [Coordinator] = []
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.ctSettingViewController = CTSettingViewController()
    }
    
    func start() {
        self.ctSettingViewController.viewModel = CTSettingViewModel(
            coordinator: self,
            ctSettingUseCase: DefaultCTSettingUseCase()
        )
        self.navigationController.pushViewController(self.ctSettingViewController, animated: true)
    }
    
    
    
    func showCTFlow() {
        // 코딩 테스트 플로우
    }
    
}
