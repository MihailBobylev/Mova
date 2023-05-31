//
//  MocardView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 19.12.2022.
//

import SwiftUI

struct MocardView: View {
    @ObservedObject private var mocardViewModel = MocardViewModel()
    let cardName: String
    let cardNumber: String
    let expiryDateMonth: String
    let expiryDateYear: String
    
    var body: some View {
        Image("mocard")
            .resizable()
            .scaledToFit()
            .overlay(
                GeometryReader { geo in
                    VStack(spacing: 0) {
                        CardNumberField(mocardViewModel: mocardViewModel, cardNumber: cardNumber, geo: geo)
                        Spacer()
                        HStack {
                            CardHolderField(mocardViewModel: mocardViewModel, cardName: cardName)
                            
                            ExpiryDateView(mocardViewModel: mocardViewModel, expiryDateMonth: expiryDateMonth, expiryDateYear: expiryDateYear)
                            Spacer()
                        }
                        .padding(.leading, 30.dhs)
                        .padding(.bottom, 29.dvs)
                    }
                }
            )
    }
}

struct MocardView_Previews: PreviewProvider {
    static var previews: some View {
        MocardView(cardName: "Mikhail Bobylev", cardNumber: "1111 4444 5555 6666", expiryDateMonth: "01", expiryDateYear: "22")
    }
}

struct CardNumberField: View {
    @ObservedObject var mocardViewModel: MocardViewModel
    let cardNumber: String
    let geo: GeometryProxy
    
    var body: some View {
        HStack {
            if cardNumber.isEmpty {
                Text("•••• •••• •••• ••••")
                    .font(.Urbanist.Bold.size(of: geo.size.width * 0.13)) // 66.dfs
                    .foregroundColor(Color.white)
                    .padding(.leading, 30.dhs)
                    .padding(.top, geo.size.height * 0.35)
            } else {
                Text(mocardViewModel.regexCardNumber(cardNumber))
                    .font(.Urbanist.Bold.size(of: geo.size.width * 0.05))
                    .foregroundColor(Color.white)
                    .padding(.leading, 30.dhs)
                    .padding(.top, geo.size.height * 0.46)
            }
            Spacer()
        }
    }
}

struct CardHolderField: View {
    @ObservedObject var mocardViewModel: MocardViewModel
    let cardName: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Card Holder Name")
                .font(.Urbanist.Medium.size(of: 10.dfs))
                .foregroundColor(Color.white)
            if cardName.isEmpty {
                Text("•••• ••••")
                    .font(.Urbanist.Medium.size(of: 14.dfs))
                    .foregroundColor(Color.white)
            } else {
                Text(mocardViewModel.regexCardName(cardName))
                    .font(.Urbanist.SemiBold.size(of: 12.dfs))
                    .foregroundColor(Color.white)
            }
        }
        .padding(.trailing, 52.58.dhs)
    }
}

struct ExpiryDateView: View {
    @ObservedObject var mocardViewModel: MocardViewModel
    let expiryDateMonth: String
    let expiryDateYear: String
    
    var body: some View {
        VStack(alignment: .leading)  {
            Text("Expiry date")
                .font(.Urbanist.Medium.size(of: 10.dfs))
                .foregroundColor(Color.white)
            if expiryDateMonth.isEmpty && expiryDateYear.isEmpty {
                Text("••••/••••")
                    .font(.Urbanist.Medium.size(of: 14.dfs))
                    .foregroundColor(Color.white)
            } else {
                Text("\(mocardViewModel.regexExpiryDate(expiryDateMonth))/\(mocardViewModel.regexExpiryDate(expiryDateYear))")
                    .font(.Urbanist.SemiBold.size(of: 12.dfs))
                    .foregroundColor(Color.white)
            }
            
        }
    }
}
