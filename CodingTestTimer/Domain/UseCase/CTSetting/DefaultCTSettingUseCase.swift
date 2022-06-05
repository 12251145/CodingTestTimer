//
//  DefaultCTSettingUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Combine
import UIKit

final class DefaultCTSettingUseCase: CTSettingUseCase {
    var problems = CurrentValueSubject<[Problem], Never>([])
    
    func addProblem() {
        problems.value.append(Problem(difficulty: .three, checkEfficiency: true))
    }
}
