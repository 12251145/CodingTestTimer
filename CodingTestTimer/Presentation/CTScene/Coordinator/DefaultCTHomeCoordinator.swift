//
//  DefaultCTHomeCoorinator.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/09.
//

import UIKit

final class DefaultCTHomeCoordinator: CTHomeCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType = .ctHome
    
    func start() {
        let ctSettingCoordinator = DefaultCTSettingCoordinator(self.navigationController)
        ctSettingCoordinator.finishDelegate = self
        ctSettingCoordinator.settingFinishDelegate = self
        self.childCoordinators.append(ctSettingCoordinator)
        ctSettingCoordinator.start()
    }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func showCTFlow(with settingData: CTSetting) {
        let ctCoordinator = DefaultCTCoordinator(self.navigationController)
        ctCoordinator.finishDelegate = self
        self.childCoordinators.append(ctCoordinator)
        ctCoordinator.pushCTViewController(with: settingData)
    }
}

extension DefaultCTHomeCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0.type != childCoordinator.type }
    }
}

extension DefaultCTHomeCoordinator: SettingCoordinatorDidFinishDelegate {
    func settingCoordinatorDidFinish(with ctSettingData: CTSetting) {
        
        self.showCTFlow(with: ctSettingData)
    }
}
