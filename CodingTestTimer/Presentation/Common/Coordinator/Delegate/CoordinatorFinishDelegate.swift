//
//  CoordinatorFinishDelegate.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/29.
//

import Foundation

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}
