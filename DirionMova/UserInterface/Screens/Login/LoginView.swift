//
//  LoginView.swift
//  DirionMova
//
//  Created by Юрий Альт on 05.10.2022.
//

import SwiftUI

enum SelectedTextField {
    case fullName
    case name
    case userName
    case email
    case password
    case createPassword
    case confirmPassword
    case phoneNumber
    case fullPhoneNumber
    case searchField
    case cardName
    case cardNumber
    case cardCVV
    case none
    case expiryDateMonth
    case expiryDateYear
    
    var placeholder: String {
        switch self {
        case .fullName:
            return "Full Name"
        case .name:
            return "Nickname"
        case .userName:
            return "Username"
        case .email:
            return "Email"
        case .password:
            return "Password"
        case .createPassword:
            return "Create the password"
        case .confirmPassword:
            return "Repeat the password"
        case .fullPhoneNumber:
            return "Phone Number"
        case .cardName:
            return "Card Holder Name"
        case .cardNumber:
            return "Card Number"
        case .cardCVV:
            return "CVC/CVV"
        case .expiryDateMonth:
            return "MM"
        case .expiryDateYear:
            return "YY"
        default:
            return ""
        }
    }
}

struct LoginView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isSorryTopupDisplayed = false
    @State private var selectedField: SelectedTextField = .none
    
    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .center) {
                Color(Color.Login.background)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    HStack {
                        Button(action: { coordinator.pop() }) {
                            Image("arrowLeftLight")
                                .frame(width: 28, height: 28)
                        }
                        .padding(.top, 34.dvs)
                        .padding(.leading, 28.dhs)
                        Spacer()
                    }
                    AppLogoView(size: 88)
                        .frame(width: 88, height: 88)
                        .padding(.top, 29.dvs)
                    Text("Login to Your Account")
                        .font(Font.Urbanist.Bold.size(of: 32.dfs))
                        .padding(.top, 43.dvs)
                    
                    VStack(spacing: 24.dvs) {
                        UsernameTextFieldView(text: $loginViewModel.userName, type: .userName)
                            .padding([.leading, .trailing], 24.dhs)
                        MovaPasswordTextFieldView(text: $loginViewModel.password, type: .password)
                            .padding([.leading, .trailing], 24.dhs)
                            .padding(.top, 12.dvs)
                        if !loginViewModel.errorMessage.isEmpty {
                            Text(loginViewModel.errorMessage)
                                .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                                .foregroundColor(.Login.errorText)
                        }
                        Button("Sign in") {
                            UIApplication.shared.dismissKeyboard()
                            loginViewModel.isTransparentBackgroundDisplayed.toggle()
                            loginViewModel.auth()
                        }
                        .disabled(!loginViewModel.formDataIsValid)
                        .frame(height: 58.dvs, alignment: .center)
                        .padding([.leading, .trailing], 24.dhs)
                        .buttonStyle(MovaButton(isButtonActive: loginViewModel.formDataIsValid))
                        Button(action: { coordinator.show(.selectResetContact) }) {
                            Text("Forgot the password?")
                                .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                                .foregroundColor(.Login.forgotThePasswordButtonText)
                        }
                        HStack {
                            Rectangle()
                                .frame(height: 1)
                                .padding(.leading, 34.dhs)
                                .foregroundColor(.Login.devider)
                            Text("or continue with")
                                .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                                .foregroundColor(.Login.continueWithText)
                            Rectangle()
                                .frame(height: 1)
                                .padding(.trailing, 34.dhs)
                                .foregroundColor(.Login.devider)
                        }
                        .padding(.top, 22.dvs)
                        HStack(spacing: 20.dhs) {
                            AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "facebookLogo")
                            AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "googleLogo")
                            AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "appleLogo")
                        }
                        .padding(.top, 6.dvs)
                        HStack {
                            Text("Don’t have an account?")
                                .font(Font.Urbanist.Medium.size(of: 14.dfs))
                                .foregroundColor(.Login.doNotHaveAccountText)
                            Button(action: {
                                coordinator.show(.createAccount)
                            }) {
                                Text("Sign up")
                                    .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                                    .foregroundColor(.Login.signUpButtonText)
                            }
                        }
                        .padding(.top, 12.dvs)
                    }
                    .padding(.top, 28.dvs)
                    Spacer()
                }
                Color.PopupWithButtonView.background
                    .ignoresSafeArea()
                    .opacity(loginViewModel.isTransparentBackgroundDisplayed ? 1 : 0)
                    .animation(.easeIn(duration: 0.2))
                LoadingPopupView(isDisplayed: $loginViewModel.isUserLoginSuccess, type: .success)
                PopupWithButtonView(viewType: .serviceIsTemporaryUnavailable, isDisplayed: $isSorryTopupDisplayed)
            }
            .onAppear {
                loginViewModel.resetAllStates()
            }
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
            .onChange(of: loginViewModel.goToHomeScreen, perform: { newValue in
                if newValue {
                    coordinator.show(.pin(flow: .create))
                }
            })
            .navigationBarHidden(true)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
