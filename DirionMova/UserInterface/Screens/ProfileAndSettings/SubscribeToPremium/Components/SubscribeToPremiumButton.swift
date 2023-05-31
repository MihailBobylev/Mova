//
//  SubscribeToPremiumButton.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 15.12.2022.
//

import SwiftUI

enum SubscribeToPremiumType {
    case month
    case year
    
    var title: String {
        switch self {
        case .month:
            return "/month"
        case .year:
            return "/year"
        }
    }
    
    var price: Double {
        switch self {
        case .month:
            return 9.99
        case .year:
            return 99.99
        }
    }
    
    var tax: Double {
        switch self {
        case .month:
            return 1.99
        case .year:
            return 19.99
        }
    }
}

struct SubscribeToPremiumButton: View {
    @State private var buttonPressed = false
    let rowsText = ["Watch all you want. Ad-free.", "Allows streaming at 4K.", "Video & Audio Quality is Better."]
    let type: SubscribeToPremiumType
    let action: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 32)
                .fill(getBackColor())
                .overlay(RoundedRectangle(cornerRadius: 32).stroke(Color.ProfileAndSettingsView.joinPremiumBorder, lineWidth: 2))
                .frame(width: 380.dhs, height: 298.dvs)
            VStack(spacing: 8.dvs) {
                Image("crownPremium")
                    .resizable()
                    .frame(width: 60.dhs, height: 60.dhs)
                    .padding(.top, 24.dvs)
                HStack(spacing: 16.dhs) {
                    Text("$\(type.price.roundToTwo)")
                        .font(.Urbanist.Bold.size(of: 32.dfs))
                        .foregroundColor(.SubscribeToPremium.priceColor)
                    Text(type.title)
                        .font(.Urbanist.Medium.size(of: 18.dhs))
                        .foregroundColor(.SubscribeToPremium.descriptionPremiumText)
                }
                Divider()
                    .frame(width: 332.dhs)
                    .foregroundColor(.SubscribeToPremium.horisontalDevider)
                VStack(alignment: .leading, spacing: 4.dvs) {
                    ForEach(rowsText, id: \.self) { text in
                        SubscribeRow(text: text)
                    }
                }
                .padding(.bottom, 24.dvs)
            }
            .frame(width: 380.dhs, height: 298.dvs)
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    buttonPressed = true
                }
                .onEnded { _ in
                    buttonPressed = false
                    action()
                }
        )
    }
    
    func getBackColor() -> Color {
        buttonPressed ? Color.SubscribeToPremium.rateBackgroundPressed : Color.SubscribeToPremium.rateBackground
    }
}

struct SubscribeToPremiumButton_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeToPremiumButton(type: .year) {
            
        }
    }
}

struct SubscribeRow: View {
    let text: String
    
    var body: some View {
        HStack(spacing: 20.dhs) {
            Image("checkRed")
            Text(text)
                .font(.Urbanist.Medium.size(of: 16.dfs))
                .foregroundColor(.SubscribeToPremium.rowText)
            Spacer()
        }
        .padding(.leading, 24.dhs)
    }
}
