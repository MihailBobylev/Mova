//
//  MocardViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 21.12.2022.
//

import Foundation

class MocardViewModel: ObservableObject {
    func regexCardName(_ cardName: String) -> String {
        cardName.replacingOccurrences(
            of: "[^A-Za-z ]",
            with: "",
            options: .regularExpression
        )
    }
    
    func regexCardNumber(_ cardNumber: String) -> String {
        cardNumber.replacingOccurrences(
            of: "[^0-9 ]",
            with: "",
            options: .regularExpression
        )
    }
    
    func regexExpiryDate(_ expiryDate: String) -> String {
        expiryDate.replacingOccurrences(
            of: "[^0-9]",
            with: "",
            options: .regularExpression
        )
    }
}
