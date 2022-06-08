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
            ctSettingUseCase: DefaultCTSettingUseCase(ctSetting: CTSetting(timeLimit: 3.0, problems: []))
        )
        self.navigationController.pushViewController(self.ctSettingViewController, animated: true)
    }
    
    func pushCTPreparationViewController(with settingData: CTSetting) {
        let ctPreparationViewController = CTPreparationViewController()
        ctPreparationViewController.viewModel = CTPreparationViewModel(
            coordinator: self,
            ctSettingUseCase: DefaultCTSettingUseCase(ctSetting: settingData),
            ctPreparationgUseCase: DefaultCTPreparationUseCase()
        )
        
        ctPreparationViewController.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(ctPreparationViewController, animated: true)
    }
}
