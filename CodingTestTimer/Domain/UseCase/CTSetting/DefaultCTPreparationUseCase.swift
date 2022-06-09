//
//  DefaultCTPreparationUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//

import Combine
import UIKit

final class DefaultCTPreparationUseCase: CTPreparationUseCase {
    var isTimeOver = CurrentValueSubject<Bool, Never>(false)
    private let maxTime = 1
    var subscriptions = Set<AnyCancellable>()
    
    func executeTimer() {
        let start = Date()
        
        Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .map{ output in
                return output.timeIntervalSince(start)
            }
            .map { timeInterval in
                return Int(timeInterval)
            }
            .sink { [weak self] time in
                self?.updateTimer(with: time)
            }
            .store(in: &subscriptions)
    }
    
    func updateTimer(with time: Int) {
        if time == maxTime {
            subscriptions.removeAll()
            self.isTimeOver.send(true)
        }
    }
}



