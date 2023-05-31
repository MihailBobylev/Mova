//
//  SuccessPopupView.swift
//  DirionMova
//
//  Created by Юрий Альт on 12.10.2022.
//

import SwiftUI

enum LoadingPopUpType {
    case success, denied
    
    var title: String {
        switch self {
        case .success:
            return "Congratulations!"
        case .denied:
            return "Access Denied"
        }
    }
    
    var description: String {
        switch self {
        case .success:
            return "Your account is ready to use. You will be redirected to the Home page in a few seconds.."
        case .denied:
            return "You will be redirected to the Start page in a few seconds"
        }
    }
}

struct LoadingPopupView: View {
    @Binding var isDisplayed: Bool
    let type: LoadingPopUpType
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 40)
                .foregroundColor(.PopupWithButtonView.mainViewBackground)
            VStack(spacing: 0) {
                Image("shieldLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 186.dhs, height: 180.dvs)
                    .padding(.top, 40.dvs)
                Text(type.title)
                    .font(.Urbanist.Bold.size(of: 24.dfs))
                    .foregroundColor(Color.PopupWithButtonView.titleText)
                    .padding(.top, 32.dvs)
                Text(type.description)
                    .multilineTextAlignment(.center)
                    .font(.Urbanist.Regular.size(of: 16.dfs))
                    .foregroundColor(Color.PopupWithButtonView.subTitleText)
                    .padding([.leading, .trailing], 40.dhs)
                    .padding(.top, 16.dvs)
                    .padding(.bottom, 20.dvs)
                LoadingIndicatorView(size: 60)
                    .frame(width: 60, height: 60, alignment: .center)
                Spacer()
            }
        }
        .opacity(isDisplayed ? 1 : 0)
        .animation(.easeIn(duration: 0.2))
        .frame(width: 340.dhs, height: 487.dvs, alignment: .center)
    }
}

struct LoadingPopupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            LoadingPopupView(isDisplayed: .constant(true), type: .success)
        }
    }
}
