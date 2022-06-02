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
    }
    
    struct Output {
        
    }
    
    func transform(input: Input, subscriptions: inout Set<AnyCancellable>) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .sink { _ in
                print("CTSettintViewController - viewDidLoad")
            }
            .store(in: &subscriptions)
        
        return output
    }
}
