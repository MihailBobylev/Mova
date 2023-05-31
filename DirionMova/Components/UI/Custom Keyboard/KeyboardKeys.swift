//
//  KeyboardKeys.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/31/22.
//

import Foundation

enum KeyboardKeys: CaseIterable, Hashable, Identifiable {
    var id: Self { self }
    
    static var allCases: [KeyboardKeys] = [
        .first, .second, .third, .fourth, .fifth, .sixth,
        .seventh, .eighth, .ninth, .custom(nil), .zero, .delete
    ]
    
    case first, second, third, fourth, fifth, sixth
    case seventh, eighth, ninth, zero, delete
    case custom(String?)
    
    var text: String? {
        switch self {
        case .first:
            return "1"
        case .second:
            return "2"
        case .third:
            return "3"
        case .fourth:
            return "4"
        case .fifth:
            return "5"
        case .sixth:
            return "6"
        case .seventh:
            return "7"
        case .eighth:
            return "8"
        case .ninth:
            return "9"
        case .custom(let text):
            return text
        case .zero:
            return "0"
        case .delete:
            return ""
        }
    }
}
