//
//  CodingTestViewModel.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/19.
//

import Combine
import Foundation

class CodingTestViewModel: ObservableObject {
    @Published var timeLimit: Double = 3.0
    
    var subscriptions = Set<AnyCancellable>()
    
    func increaseTimeLimit(_ time: Double) {
        timeLimit += time
    }
}
