//
//  CTSettingViewModel.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Combine
import Foundation

final class CTSettingViewModel {
    weak var coordinator: CTSettingCoordinator?
    private let ctSettingUseCase: CTSettingUseCase
    
    init(coordinator: CTSettingCoordinator, ctSettingUseCase: CTSettingUseCase) {
        self.coordinator = coordinator
        self.ctSettingUseCase = ctSettingUseCase
    }
}
