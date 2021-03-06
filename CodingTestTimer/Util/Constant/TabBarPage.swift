//
//  TabBarPage.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/05/30.
//

import Foundation

enum TabBarPage: String, CaseIterable {
    case codingTest, history
    
    init?(index: Int) {
        switch index {
        case 0: self = .codingTest
        case 1: self = .history
        default: return nil
        }
    }
    
    func pageOrderNumber() -> Int {
        switch self {
        case .codingTest:
            return 0
        case .history:
            return 1
        }
    }
}
