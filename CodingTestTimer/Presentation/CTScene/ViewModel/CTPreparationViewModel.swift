//
//  CTPreparationViewModel.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//


import Combine
import UIKit

final class CTPreparationViewModel {
    weak var coordinator: CTSettingCoordinator?
    private let ctSettingUseCase: CTSettingUseCase
    private let ctPreparationUseCase: CTPreparationUseCase
    
    init(coordinator: CTSettingCoordinator, ctSettingUseCase: CTSettingUseCase, ctPreparationgUseCase: CTPreparationUseCase) {
        self.coordinator = coordinator
        self.ctSettingUseCase = ctSettingUseCase
        self.ctPreparationUseCase = ctPreparationgUseCase
    }
    
    struct Input {
        let viewDidLoadEvent: AnyPublisher<Void, Never>
    }
    
    struct Output {
        
    }
    
    func transform(form input: Input, subscriptions: inout Set<AnyCancellable>) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .sink { _ in
                print("CTPreparationViewController - viewDidLoad")                
                self.ctPreparationUseCase.executeTimer()
            }
            .store(in: &subscriptions)
        
        self.ctPreparationUseCase.isTimeOver
            .sink { [weak self] isOver in
                if isOver {
                    let settingData = self?.ctSettingUseCase.ctSetting.value
                    self?.coordinator?.finish(with: settingData!)
                }
            }
            .store(in: &subscriptions)
        
        return output
    }
}
