//
//  Double + Formatter.swift
//  CodingTestTimer
//
//  Created by Hoen on 2022/06/12.
//

import Foundation

extension Double {
    var hhmm: String {
        let h = Int(floor(self))
        let m = self.truncatingRemainder(dividingBy: 1.0)
        
        let hh = "\(h)"
        let mm = m == 0.5 ? "30" : "00"
        
        return "\(hh)시간 \(mm)분"
    }
}
