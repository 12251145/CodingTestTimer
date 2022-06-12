//
//  Int + Formatter.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/12.
//

import Foundation

extension Int {
    var hhmmss: String {
        if self < 0 { return "00:00:00" }
        
        let s = self % 60
        let m = self / 60 % 60
        let h = self / 3600
        
        let ss = s < 10 ? "0\(s)" : "\(s)"
        let mm = m < 10 ? "0\(m)" : "\(m)"
        let hh = h < 10 ? "0\(h)" : "\(h)"
        
        return "\(hh)시 \(mm)분 \(ss)초"
    }
}
