//
//  DefaultCTSettingUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Combine
import UIKit

final class DefaultCTSettingUseCase: CTSettingUseCase {
    var ctSetting: CurrentValueSubject<CTSetting, Never>
    
    init(
        ctSetting: CTSetting
    ) {
        self.ctSetting = CurrentValueSubject<CTSetting, Never>(ctSetting)
    }
    
    func addProblem() {
        self.ctSetting.value.problems.append(Problem(difficulty: .three, checkEfficiency: false))
    }
    
    func updateTime(_ amount: Double) {
        self.ctSetting.value.timeLimit += amount
    }
}
