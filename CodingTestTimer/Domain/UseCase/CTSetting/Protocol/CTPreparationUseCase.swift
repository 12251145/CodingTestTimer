//
//  CTPreparationUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/08.
//

import Combine
import UIKit

protocol CTPreparationUseCase {
    var isTimeOver: CurrentValueSubject<Bool, Never> { get set }    
    
    func executeTimer()
}
