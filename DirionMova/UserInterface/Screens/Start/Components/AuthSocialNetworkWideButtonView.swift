//
//  AuthSocialNetworkWideButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.10.2022.
//

import SwiftUI

struct AuthSocialNetworkWideButtonView: View {
    let action: () -> ()
    let imageName: String
    let buttonText: String
    
    var body: some View {
        
        GeometryReader { geo in
            HStack {
                Spacer()
                Button(action: action) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .frame(width: geo.size.width * 0.90, height: 60.dvs)
                            .foregroundColor(.AuthSocialNetworkButton.background)
                            .overlay(
                                RoundedRectangle(cornerRadius: 16).stroke(Color.AuthSocialNetworkButton.borderColor, lineWidth: 1)
                            )
                        HStack {
                            Image(imageName)
                                .frame(width: 24, height: 24)
                            Text(buttonText)
                                .font(Font.Urbanist.SemiBold.size(of: 16))
                                .foregroundColor(.AuthSocialNetworkButton.text)
                        }
                    }
                    
                }
                Spacer()
            }
        }
        .frame(height: 60.dvs)
    }
}

struct AuthSocialNetworkWideButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSocialNetworkWideButtonView(action: {}, imageName: "appleLogo", buttonText: "Continue with Apple")
    }
}
