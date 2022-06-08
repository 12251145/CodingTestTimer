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
        let startButtonDidTap: AnyPublisher<Void, Never>
        let addProblemButtonEvent: AnyPublisher<Void, Never>
        let addTimeButtonEvent: AnyPublisher<Double, Never>
    }
    
    struct Output {
        var ctSetting = CurrentValueSubject<CTSetting, Never>(CTSetting(timeLimit: 3.0, problems: []))
    }
    
    func transform(input: Input, subscriptions: inout Set<AnyCancellable>) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .sink { _ in
                print("CTSettintViewController - viewDidLoad")
            }
            .store(in: &subscriptions)
        
        input.startButtonDidTap
            .sink { [weak self] _ in
                self?.coordinator?.pushCTPreparationViewController(with: self?.ctSettingUseCase.ctSetting.value ?? CTSetting(timeLimit: 3.0, problems: []))
            }
            .store(in: &subscriptions)
        
        input.addProblemButtonEvent
            .sink { _ in
                self.ctSettingUseCase.addProblem()
            }
            .store(in: &subscriptions)
        
        input.addTimeButtonEvent
            .sink { value in                
                self.ctSettingUseCase.updateTime(value)
            }
            .store(in: &subscriptions)
        
        self.ctSettingUseCase.ctSetting
            .map { $0.problems }
            .sink { problems in
                output.ctSetting.value.problems = problems
            }
            .store(in: &subscriptions)
        
        self.ctSettingUseCase.ctSetting
            .map{ $0.timeLimit }
            .sink { time in
                output.ctSetting.value.timeLimit = time
            }
            .store(in: &subscriptions)
        
        return output
    }
}
