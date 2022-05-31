//
//  HistoryViewModel.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Foundation

class HistoryViewModel {
    weak var coordinator: HistoryCoordinator?
    private let historyUseCase: HistoryUseCase
    
    init(coordinator: HistoryCoordinator, historyUseCase: HistoryUseCase) {
        self.coordinator = coordinator
        self.historyUseCase = historyUseCase
    }
}
