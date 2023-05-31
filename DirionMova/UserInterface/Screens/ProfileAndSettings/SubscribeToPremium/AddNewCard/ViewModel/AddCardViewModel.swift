//
//  AddCardViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 16.12.2022.
//

import Foundation

class AddCardViewModel: ObservableObject {
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    @Published var fieldsIsValid = false
    @Published var isDisplaySuccessPopUp = false
    
    @Published var cardName = "" {
        didSet {
            if let _cardName = regexCardName(cardName){
                cardName = _cardName
            }
            if cardName.count > 32 {
                cardName = String(cardName.prefix(32))
            }
            fieldsIsValid = isValidFields()
        }
    }
    @Published var cardNumber = "" {
        didSet {
            if oldValue.count < cardNumber.count {
                if let _cardNumber = regexCardNumber(cardNumber){
                    cardNumber = _cardNumber
                } else {
                    if cardNumber.count > 19 {
                        cardNumber = String(cardNumber.prefix(19))
                    } else {
                        if let _cardNumber = addSpaces(cardNumber) {
                            cardNumber = _cardNumber
                        }
                    }
                }
            }
            fieldsIsValid = isValidFields() && lunaAlg()
        }
    }
    
    @Published var cardCVV = "" {
        didSet {
            if let _cvv = regexExpiryDateAndCVV(cardCVV){
                cardCVV = _cvv
            }
            if cardCVV.count > 3 {
                cardCVV = String(cardCVV.prefix(3))
            }
            fieldsIsValid = isValidFields()
        }
    }
    
    @Published var expiryDateMonth = "" {
        didSet {
            if let _expiryDateMonth = regexExpiryDateAndCVV(expiryDateMonth){
                expiryDateMonth = _expiryDateMonth
            }
            if expiryDateMonth.count > 2 {
                expiryDateMonth = String(expiryDateMonth.prefix(2))
            }
            fieldsIsValid = isValidFields()
        }
    }
    
    @Published var expiryDateYear = "" {
        didSet {
            if let _expiryDateYear = regexExpiryDateAndCVV(expiryDateYear){
                expiryDateYear = _expiryDateYear
            }
            if expiryDateYear.count > 2 {
                expiryDateYear = String(expiryDateYear.prefix(2))
            }
            fieldsIsValid = isValidFields()
        }
    }
    
    private func isValidFields() -> Bool {
        guard cardName.count >= 2 && cardName.count <= 32 else { return false }
        guard cardNumber.count == 19 else { return false }
        guard cardNumberIsValid() else { return false }
        guard expiryDateIsValid() else { return false }
        guard cardCVV.count == 3 else { return false }
        
        return true
    }
    
    private func expiryDateIsValid() -> Bool {
        guard expiryDateMonth.count == 2 && Int(expiryDateMonth) ?? 0 >= 1 && Int(expiryDateMonth) ?? 0 <= 12 else { return false }
        guard expiryDateYear.count == 2 else { return false }
        
        let calendar = Calendar.current
        let date = Date()
        let year = "20\(expiryDateYear)"
        
        let dateComponents = DateComponents(calendar: calendar, timeZone: .current, year: Int(year), month: Int(expiryDateMonth))
        let cardDate = calendar.date(from: dateComponents) ?? date
        
        let componentsFromCurrentDate = calendar.dateComponents([.year, .month], from: date)
        let currentDate = calendar.date(from: componentsFromCurrentDate)
        
        guard currentDate?.compare(cardDate) == .orderedAscending else { return false }
        
        return true
    }
    
    private func cardNumberIsValid() -> Bool {
        let CARD_REGEX = "^\\d{4} \\d{4} \\d{4} \\d{4}$"
        
        let result = cardNumber.range(
            of: CARD_REGEX,
            options: .regularExpression
        )

        return result != nil
    }
    
    private func addSpaces(_ cardNumber: String) -> String? {
        let length = cardNumber.count
        let number = cardNumber.replacingOccurrences(of: " ", with: "")
        var numberWithSpaces = ""
        
        for (index, char) in number.enumerated() {
            numberWithSpaces += String(char)
            if (index+1) % 4 == 0 && index != 16 {
                numberWithSpaces += " "
            }
            if index == 15 {
                break
            }
        }
        
        return length == numberWithSpaces.count ? nil : numberWithSpaces
    }
    
    private func lunaAlg() -> Bool {
        let number = cardNumber.replacingOccurrences(of: " ", with: "")
        var firstSet = ""
        var secondSet = ""
        var sum1 = 0
        var sum2 = 0
        
        for (index, char) in number.enumerated() {
            if index % 2 == 0 {
                if let intValue = char.wholeNumberValue {
                    firstSet += String(intValue * 2)
                }
            } else {
                secondSet += String(char)
            }
        }
        
        for char in firstSet {
            if let intValue = char.wholeNumberValue {
                sum1 += intValue
            }
        }
        
        for char in secondSet {
            if let intValue = char.wholeNumberValue {
                sum2 += intValue
            }
        }
        return (sum1 + sum2) % 10 == 0 ? true : false
    }
    
    func regexCardName(_ cardName: String) -> String? {
        let lenght = cardName.count
        
        let _cardName = cardName.replacingOccurrences(
            of: "[^A-Za-z ]",
            with: "",
            options: .regularExpression
        )
        
        return lenght == _cardName.count ? nil : _cardName
    }
    
    func regexCardNumber(_ cardNumber: String) -> String? {
        let lenght = cardNumber.count
        
        var _cardNumber = cardNumber.replacingOccurrences(
            of: "[^0-9 ]",
            with: "",
            options: .regularExpression
        )
        _cardNumber = _cardNumber.replacingOccurrences(
            of: "^ ",
            with: "",
            options: .regularExpression
        )
        _cardNumber = _cardNumber.replacingOccurrences(
            of: " {2,}",
            with: " ",
            options: .regularExpression
        )
        
        return lenght == _cardNumber.count ? nil : _cardNumber
    }
    
    func regexExpiryDateAndCVV(_ text: String) -> String? {
        let lenght = text.count
        
        let _text = text.replacingOccurrences(
            of: "[^0-9]",
            with: "",
            options: .regularExpression
        )
        
        return lenght == _text.count ? nil : _text
    }
    
    func saveNewCard(_ mocard: Mocard) {
        storage.addNewCard = mocard
    }
}
