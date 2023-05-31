//
//  PaymentMethodReview.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.12.2022.
//

import SwiftUI

struct PaymentMethodReview: View {
    let mocard: Mocard
    let tapAction: () -> ()
    
    var body: some View {
        GeometryReader { geo in
            Button {
                tapAction()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(width: geo.size.width, height: 80.dvs)
                        .foregroundColor(.Payment.tileBack)
                    HStack {
                        Image(getCardImage())
                            .padding(.leading, 24.dhs)
                        Text("•••• •••• •••• \(getLastFourNumbersOfCard())")
                            .font(.Urbanist.Bold.size(of: 18.dfs))
                            .foregroundColor(.Payment.textColor)
                            .padding(.leading, 12.dhs)
                        Spacer()
                        Text("Change")
                            .font(.Urbanist.Bold.size(of: 16.dfs))
                            .padding(.trailing, 24.dhs)
                    }
                }
            }
        }
        .frame(height: 80.dvs)
    }
    
    func getCardImage() -> String {
        
        if let firstNum = mocard.cardNumber.first?.description, firstNum == "4" {
            return "visa"
        } else {
            return "mastercard"
        }
    }
    
    func getLastFourNumbersOfCard() -> String {
        let index = mocard.cardNumber.index(mocard.cardNumber.endIndex, offsetBy: -4)
        let lastFournumbers = mocard.cardNumber.suffix(from: index)
        
        return String(lastFournumbers)
    }
}

struct PaymentMethodReview_Previews: PreviewProvider {
    static var previews: some View {
        PaymentMethodReview(mocard: Mocard(cardName: "", cardNumber: "4444 4444 4444 4444", expiryDateMonth: "01", expiryDateYear: "23")) {}
    }
}
