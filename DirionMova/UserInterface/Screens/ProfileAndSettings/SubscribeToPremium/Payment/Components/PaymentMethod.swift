//
//  PaymentMethod.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 15.12.2022.
//

import SwiftUI

enum PaymentMethodType {
    case payPal
    case googlePay
    case applePay
    case mocard
    case none
    
    var paymentTitle: String {
        switch self {
        case .payPal:
            return "PayPal"
        case .googlePay:
            return "Google Pay"
        case .applePay:
            return "Apple Pay"
        case .mocard:
            return "•••• •••• •••• "
        case .none:
            return ""
        }
    }
    
    var paymentImage: String {
        switch self {
        case .payPal:
            return "payPal"
        case .googlePay:
            return "googlePay"
        case .applePay:
            return "applePay"
        case .none, .mocard:
            return ""
        }
    }
}

struct PaymentMethod: View {
    let type: PaymentMethodType
    var mocard = Mocard(cardName: "", cardNumber: "", expiryDateMonth: "", expiryDateYear: "")
    
    @Binding var selected: PaymentMethodType
    
    var body: some View {
        GeometryReader { geo in
            Button {
                selected = type
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: geo.size.width, height: 80.dvs)
                        .foregroundColor(.Payment.tileBack)
                    HStack {
                        Image(getPaymentImage())
                            .padding(.leading, 24.dhs)
                        Text(getPaymentTitle())
                            .font(.Urbanist.Bold.size(of: 18.dfs))
                            .foregroundColor(.Payment.textColor)
                            .padding(.leading, 12.dhs)
                        Spacer()
                        Image(selected == type ? "circleFill" : "circleEmpty")
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 24.dhs)
                    }
                }
            }
        }
        .frame(height: 80.dvs)
    }
}

struct PaymentMethod_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethod(type: .payPal, selected: .constant(.payPal))
    }
}

// Payment properties
extension PaymentMethod {
    func getPaymentTitle() -> String {
        if mocard.cardName.isEmpty {
            return type.paymentTitle
        } else {
            let title = type.paymentTitle + getLastFourNumbersOfCard()
            return title
        }
    }
    
    func getLastFourNumbersOfCard() -> String {
        let index = mocard.cardNumber.index(mocard.cardNumber.endIndex, offsetBy: -4)
        let lastFournumbers = mocard.cardNumber.suffix(from: index)
        
        return String(lastFournumbers)
    }
    
    func getPaymentImage() -> String {
        if type == .mocard {
            return getCardImage()
        } else {
            return type.paymentImage
        }
    }
    
    func getCardImage() -> String {
        
        if let firstNum = mocard.cardNumber.first?.description, firstNum == "4" {
            return "visa"
        } else {
            return "mastercard"
        }
    }
}
