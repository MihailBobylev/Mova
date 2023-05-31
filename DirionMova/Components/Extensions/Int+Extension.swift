//
//  Int+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/13/22.
//

import Foundation

extension Int {
    var stringValue: String {
        return "\(self)"
    }
}

extension Int64 {
    var getSizeMB: String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB, .useKB]
        bcf.includesUnit = true
        return bcf.string(fromByteCount: self)
    }
}
