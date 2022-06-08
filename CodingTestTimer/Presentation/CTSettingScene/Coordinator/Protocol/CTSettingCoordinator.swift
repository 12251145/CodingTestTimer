//
//  File.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Foundation

protocol CTSettingCoordinator: Coordinator {
    func pushCTPreparationViewController(with settingData: CTSetting)
}
