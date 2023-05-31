//
//  SorryPopupView.swift
//  DirionMova
//
//  Created by Юрий Альт on 12.10.2022.
//

import SwiftUI

struct PopupWithButtonView: View {
    let viewType: ErrorPopupType
    @Binding var isDisplayed: Bool
    @State private var title = "Sorry"
    @State private var subtitle = ""
    @State private var imageName = "shieldLogo"
    @State private var isLoadingIndicatorVisible = false
    @State private var buttonText = "OK"
    let customAction: (() -> Void)?
    
    enum ErrorPopupType {
        case serviceIsTemporaryUnavailable
        case somethingWentWrong
        case successfullySubscribedMonth
        case successfullySubscribedYear
        case noInternetConnection
        case biometricTurnedOff
        case addedCard
    }
    
    init(viewType: ErrorPopupType, isDisplayed: Binding<Bool>, buttonText: String = "OK", customAction: (() -> Void)? = nil) {
        self.viewType = viewType
        self.buttonText = buttonText
        self.customAction = customAction
        self._isDisplayed = isDisplayed
    }
    
    var body: some View {
        ZStack {
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .onTapGesture {
                    isDisplayed.toggle()
                }
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.PopupWithButtonView.mainViewBackground)
                VStack(spacing: 0) {
                    Image(imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 186.dhs, height: 180.dvs)
                        .padding(.top, 40.dvs)
                    Text(title)
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .foregroundColor(Color.PopupWithButtonView.titleText)
                        .padding(.top, 32.dvs)
                    Text(subtitle)
                        .multilineTextAlignment(.center)
                        .font(.Urbanist.Regular.size(of: 16.dfs))
                        .foregroundColor(Color.PopupWithButtonView.subTitleText)
                        .padding([.leading, .trailing], 32.dhs)
                        .padding(.top, 16.dvs)
                        .padding(.bottom, 32.dvs)
                    Button(buttonText) {
                        isDisplayed.toggle()
                        customAction?()
                    }
                    .frame(height: 58.dvs, alignment: .center)
                    .buttonStyle(MovaButton())
                    .padding([.leading, .trailing], 32.dhs)
                    .padding(.bottom, 26.dvs)
                    Spacer()
                }
            }
            .frame(width: 340.dhs, height: 464.dvs, alignment: .center)
        }
        .opacity(isDisplayed ? 1 : 0)
        .animation(.easeIn(duration: 0.2))
        .onAppear {
            switch viewType {
            case .biometricTurnedOff:
                self.subtitle = "Please, turn on FaceID in System Settings"
                self.buttonText = "Settings"
            case .serviceIsTemporaryUnavailable:
                self.subtitle = "Service is temporarily unavailable"
            case .somethingWentWrong:
                self.subtitle = "Something went wrong. Please try again later"
            case .successfullySubscribedMonth:
                self.imageName = "crownTopupLogo"
                self.title = "Congratulations!"
                self.subtitle = "You have successfully subscribed 1 month premium. Enjoy the benefits!"
            case .successfullySubscribedYear:
                self.imageName = "crownTopupLogo"
                self.title = "Congratulations!"
                self.subtitle = "You have successfully subscribed 1 year premium. Enjoy the benefits!"
            case .noInternetConnection:
                self.subtitle = "Please make sure you’re connected to the internet and try again"
                self.buttonText = "Try again"
            case .addedCard:
                self.imageName = "crownTopupLogo"
                self.title = "Congratulations!"
                self.subtitle = "Your card has been added"
            }
        }
    }
    
    struct PopupWithButtonView_Previews: PreviewProvider {
        static var previews: some View {
            PopupWithButtonView(viewType: .successfullySubscribedMonth, isDisplayed: .constant(true), buttonText: "Button") {
                
            }
        }
    }
}


