//
//  StartView.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.10.2022.
//

import SwiftUI

protocol StartViewIxResponder {
    func redirectHomeScreen() -> Void
}

struct StartView: View {
    @StateObject private var startViewModel = StartViewModel()
    @State private var signInWithPasswordPressed = false
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @State private var isPopUpDisplayed = false
    
    var body: some View {
        ZStack {
            Color(Color.Login.background)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Image("startLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 237.dhs, height: 200.dvs)
                    .padding(.top, 16.dvs)
                Text("Let’s you in")
                    .font(Font.Urbanist.Bold.size(of: 46.dfs))
                    .padding(.top, 26.dvs)
                VStack(spacing: 16.dvs) {
                    AuthSocialNetworkWideButtonView(
                        action: {
                            startViewModel.isSorryTopupDisplayed.toggle()
                        }, imageName: "facebookLogo",
                        buttonText: "Continue with Facebook"
                    )
                    AuthSocialNetworkWideButtonView(action: {
                        startViewModel.isSorryTopupDisplayed.toggle()
                    }, imageName: "googleLogo", buttonText: "Continue with Google")
                    AuthSocialNetworkWideButtonView(action: {
                        startViewModel.isSorryTopupDisplayed.toggle()
                    }, imageName: "appleLogo", buttonText: "Continue with Apple")
                }
                .padding(.top, 20.dvs)
                HStack(spacing: 16) {
                    Rectangle()
                        .frame(height: 1)
                        .padding(.leading, 34)
                        .foregroundColor(.StartScreen.devider)
                    Text("or")
                        .font(Font.Urbanist.SemiBold.size(of: 18.dfs))
                        .foregroundColor(.StartScreen.orText)
                    Rectangle()
                        .frame(height: 1)
                        .padding(.trailing, 34)
                        .foregroundColor(.StartScreen.devider)
                }
                .padding([.top, .bottom], 16.dvs)
                Button("Sign in with password") {
                    coordinator.show(.login)
                }
                .frame(height: 58.dvs, alignment: .center)
                .buttonStyle(MovaButton())
                .padding([.leading, .trailing], 16)
                HStack {
                    Text("Don’t have an account?")
                        .font(Font.Urbanist.Regular.size(of: 14.dfs))
                        .foregroundColor(.StartScreen.doNotHaveAccountText)
                    Button(action: {
                        coordinator.show(.createAccount)
                    }) {
                        Text("Sign up")
                            .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                            .foregroundColor(Color(UIColor.MOVA.primary500))
                    }
                }
                .padding(.top, 20.dvs)
                Button(action: setupTransitionToGuestMode) {
                    Text("Enter as guest")
                        .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                        .foregroundColor(.StartScreen.orText)
                }.padding(.top, 20.dvs)
            }
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .opacity(isPopUpDisplayed ? 1 : 0)
                .animation(.easeIn(duration: 0.2))
            LoadingPopupView(isDisplayed: $isPopUpDisplayed, type: .success)
            PopupWithButtonView(viewType: .serviceIsTemporaryUnavailable,
                                isDisplayed: $startViewModel.isSorryTopupDisplayed)
        }.onAppear {
            startViewModel.delegate = self
        }
        .navigationBarHidden(true)
    }
    
    private func setupTransitionToGuestMode() {
        isPopUpDisplayed = true
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isPopUpDisplayed = false
            self.startViewModel.enterGuest()
        }
    }
    
}

extension StartView: StartViewIxResponder {
    func redirectHomeScreen() {
        coordinator.show(.home)
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}
