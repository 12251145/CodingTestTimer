//
//  CTUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/09.
//

import Combine
import UIKit

protocol CTUseCase {
    var ctSetting: CTSetting { get set }
    var ct: CurrentValueSubject<CT, Never> { get set }
    
    func executeTimer()
}
