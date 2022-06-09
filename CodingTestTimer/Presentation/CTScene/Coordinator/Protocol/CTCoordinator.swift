//
//  CTCoordinator.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/09.
//

import Foundation

protocol CTCoordinator: Coordinator {
    func pushCTViewController(with settingData: CTSetting)
}
