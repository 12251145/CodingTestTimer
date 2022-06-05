//
//  CTSettingViewModel.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Combine
import UIKit

final class CTSettingViewModel {
    weak var coordinator: CTSettingCoordinator?
    private let ctSettingUseCase: CTSettingUseCase
    
    init(coordinator: CTSettingCoordinator, ctSettingUseCase: CTSettingUseCase) {
        self.coordinator = coordinator
        self.ctSettingUseCase = ctSettingUseCase
    }
    
    struct Input {
        let viewDidLoadEvent: AnyPublisher<Void, Never>
        let testButtonEvent: AnyPublisher<Void, Never>
    }
    
    struct Output {
        var problems = CurrentValueSubject<[Problem], Never>([])
    }
    
    func transform(input: Input, subscriptions: inout Set<AnyCancellable>) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .sink { _ in
                print("CTSettintViewController - viewDidLoad")
            }
            .store(in: &subscriptions)
        
        input.testButtonEvent
            .sink { _ in
                print("문제 추가 테스트")
                self.ctSettingUseCase.addProblem()
            }
            .store(in: &subscriptions)
        
        self.ctSettingUseCase.problems
            .sink { problems in
                output.problems.value = problems
            }
            .store(in: &subscriptions)
        
        return output
    }
}
