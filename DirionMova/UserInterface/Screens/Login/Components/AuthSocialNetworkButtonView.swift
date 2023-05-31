//
//  AuthSocialNetworkButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 06.10.2022.
//

import SwiftUI

struct AuthSocialNetworkButtonView: View {
    //MARK: - Public Properties
    let action: () -> ()
    let imageName: String
    
    //MARK: - Body
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 88.dhs, height: 60.dvs)
                    .foregroundColor(.AuthSocialNetworkButton.background)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16).stroke(Color.AuthSocialNetworkButton.borderColor, lineWidth: 1)
                    )
                Image(imageName)
                    .frame(width: 24.dhs, height: 24.dvs)
            }
        }
    }
}

struct AuthSocialNetworkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AuthSocialNetworkButtonView(action: {}, imageName: "appleLogo")
    }
}
