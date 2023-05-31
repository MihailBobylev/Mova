//
//  JoinPremiumView.swift
//  DirionMova
//
//  Created by Юрий Альт on 25.11.2022.
//

import SwiftUI

struct MovaPremiumButton: View {
    
    enum MovePremiumButtonType {
        case sign, join
        
        var title: String {
            switch self {
            case .sign:
                return "Sign up or sign in"
            case .join:
                return "Join Premium!"
            }
        }
        
        var description: String {
            switch self {
            case .sign:
                return ""
            case .join:
                return "Enjoy watching Full-HD movies,\nwithout restrictions and without ads"
            }
        }
    }
    let action: () -> Void
    let type: MovePremiumButtonType
    var hideDescription = true
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color(Color.ProfileAndSettingsView.background))
                    .overlay(RoundedRectangle(cornerRadius: 32).stroke(Color.ProfileAndSettingsView.joinPremiumBorder, lineWidth: 2))
                HStack {
                    Spacer()
                    Image("crownPremium")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .padding(.trailing, 15.dhs)
                    VStack(alignment: .leading, spacing: 8.dvs) {
                        Text(type.title)
                            .font(.Urbanist.Bold.size(of: 24.dfs))
                            .foregroundColor(.ProfileAndSettingsView.joinPremiumText)
                            .lineLimit(nil)
                        if !hideDescription {
                            Text(type.description)
                                .font(.Urbanist.Regular.size(of: 12.dfs))
                                .foregroundColor(.ProfileAndSettingsView.descriptionPremiumText)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    
                    Image("arrowRight2LightRed")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.leading, 20.dhs)
                    Spacer()
                }
            }
        }
    }
}

struct MovaPremiumButton_Previews: PreviewProvider {
    static var previews: some View {
        MovaPremiumButton(action: { }, type: .join)
    }
}
