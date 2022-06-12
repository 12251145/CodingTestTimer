//
//  CTViewModel.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//

import Combine
import UIKit

final class CTViewModel {
    weak var coordinator: CTCoordinator?
    private let ctUseCase: CTUseCase
    
    init(coordinator: CTCoordinator, ctUseCase: CTUseCase) {
        self.coordinator = coordinator
        self.ctUseCase = ctUseCase
    }
    
    struct Input {
        let viewDidLoadEvent: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var ct = CurrentValueSubject<CT, Never>(CT(timeLimit: 100, leftTime: 0, problems: []))
    }
    
    func transform(from input: Input, subscriptions: inout Set<AnyCancellable>) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .sink { _ in
                print("CTViewController - viewDidLoad")                
                self.ctUseCase.executeTimer()
            }
            .store(in: &subscriptions)
        
//        self.ctUseCase.ct
//            .map { $0.leftTime }
//            .sink { leftTime in
//                output.ct.value.leftTime = leftTime
//            }
//            .store(in: &subscriptions)
//
//        self.ctUseCase.ct
//            .map { $0.timeLimit }
//            .sink { timeLimit in
//                output.ct.value.timeLimit = timeLimit
//            }
//            .store(in: &subscriptions)
        
        self.ctUseCase.ct
            .sink { ct in
                output.ct.value.timeLimit = ct.timeLimit
                output.ct.value.leftTime = ct.leftTime
            }
            .store(in: &subscriptions)
        
            
        
        return output
    }
}
