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
        
    }
    
    func transform(from input: Input, subscriptions: inout Set<AnyCancellable>) -> Output {
        let output = Output()
        
        input.viewDidLoadEvent
            .sink { _ in
                print("CTViewController - viewDidLoad")
                print(self.ctUseCase.ctSetting.value.timeLimit)
            }
            .store(in: &subscriptions)
        
        return output
    }
}
