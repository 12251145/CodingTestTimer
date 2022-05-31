//
//  DefaultHistoryCoordinator.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import UIKit

final class DefaultHistoryCoordinator: HistoryCoordinator {
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var historyViweController: HistoryViewController
    var type: CoordinatorType = .history
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.historyViweController = HistoryViewController()
    }
    
    func start() {
        self.historyViweController.viewModel = HistoryViewModel(
            coordinator: self,
            historyUseCase: DefaultHistoryUseCase()
        )
        self.navigationController.pushViewController(self.historyViweController, animated: true)
    } 
}
