//
//  CTSettingUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Combine
import UIKit

protocol CTSettingUseCase {
    var ctSetting: CurrentValueSubject<CTSetting, Never> { get set }
    
    func addProblem()
    func updateTime(_ amount: Double)
}
