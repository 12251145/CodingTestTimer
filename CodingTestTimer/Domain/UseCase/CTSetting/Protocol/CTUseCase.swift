//
//  CTUseCase.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/09.
//

import Combine
import UIKit

protocol CTUseCase {
    var ctSetting: CurrentValueSubject<CTSetting, Never> { get set }
}
