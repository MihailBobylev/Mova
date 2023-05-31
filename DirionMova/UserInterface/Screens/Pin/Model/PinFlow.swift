//
//  PinFlow.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/13/22.
//

import Foundation

enum PinFlow {
    case create, enter, confirm
    
    var title: String {
        switch self {
        case .create:
            return "Create New PIN"
        case .enter:
            return "Enter Your PIN"
        case .confirm:
            return "Confirm PIN"
        }
    }
    
    var description: String {
        switch self {
        case .create:
            return "Add a PIN number to make your account more secure"
        case .enter:
            return ""
        case .confirm:
            return "Re-enter your new PIN"
        }
    }
    
    func getErrorMessage(attempts: Int = 4) -> String {
        switch self {
        case .confirm:
            return "PINs don't match. Try again"
        case .enter:
            return "Wrong PIN \(attempts) left. Try again"
        default:
            return ""
        }
    }
}
