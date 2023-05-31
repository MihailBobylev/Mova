//
//  Double+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/27/22.
//

import Foundation

extension Double {
    var roundedStringValue: String {
        return "\(ceil(self * 10) / 10)"
    }
    
    var roundToTwo: String {
        return String(format: "%.2f", self)
    }
    
    var percent: String {
        return String(format: "%.0f", self * 100)
    }
}
