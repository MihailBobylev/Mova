//
//  Mocard.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 19.12.2022.
//

import Foundation

class Mocard: NSObject, NSCoding {
    let cardName: String
    let cardNumber: String
    let expiryDateMonth: String
    let expiryDateYear: String
    
    init(cardName: String, cardNumber: String, expiryDateMonth: String, expiryDateYear: String) {
        self.cardName = cardName
        self.cardNumber = cardNumber
        self.expiryDateMonth = expiryDateMonth
        self.expiryDateYear = expiryDateYear
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(cardName, forKey: "cardName")
        coder.encode(cardNumber, forKey: "cardNumber")
        coder.encode(expiryDateMonth, forKey: "expiryDateMonth")
        coder.encode(expiryDateYear, forKey: "expiryDateYear")
    }
    
    required init?(coder: NSCoder) {
        cardName = coder.decodeObject(forKey: "cardName") as? String ?? ""
        cardNumber = coder.decodeObject(forKey: "cardNumber") as? String ?? ""
        expiryDateMonth = coder.decodeObject(forKey: "expiryDateMonth") as? String ?? ""
        expiryDateYear = coder.decodeObject(forKey: "expiryDateYear") as? String ?? ""
    }
}
