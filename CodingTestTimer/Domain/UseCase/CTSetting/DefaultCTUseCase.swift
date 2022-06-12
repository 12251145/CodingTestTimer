//
//  DefaultCTUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/09.
//

import Combine
import UIKit

final class DefaultCTUseCase: CTUseCase {
    var ctSetting: CTSetting
    var ct: CurrentValueSubject<CT, Never>
    var subscriptions = Set<AnyCancellable>()
    
    init(
        ctSetting: CTSetting
    ) {
        self.ctSetting = ctSetting
        self.ct = CurrentValueSubject<CT, Never>(CT(
            timeLimit: Int(ctSetting.timeLimit * 3600),
            leftTime: Int(ctSetting.timeLimit * 3600),
            problems: ctSetting.problems)
        )
    }
    
    func executeTimer() {
        let start = Date()
        
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map {
                return (self.ctSetting.timeLimit * 3600) - $0.timeIntervalSince(start)
            }
            .map {
                return Int(round($0))
            }
            .sink { [weak self] leftTime in
                self?.updateTimer(with: leftTime)
            }
            .store(in: &subscriptions)
    }
}

// MARK: - Private Functions
private extension DefaultCTUseCase {
    func updateTimer(with time: Int) {
        self.ct.value.leftTime = time
    }
}
