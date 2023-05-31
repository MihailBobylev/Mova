//
//  CreateAccountView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.10.2022.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject private var createAccountModel = CreateAccountViewModel()
    @State private var isSorryTopupDisplayed = false
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color(Color.CreateAccount.background)
                    .ignoresSafeArea()
                VStack(spacing: 0) {
                    AppLogoView(size: 88)
                        .frame(width: 88, height: 88)
                    Text("Create Your Account")
                        .font(Font.Urbanist.Bold.size(of: 32.dhs))
                        .padding(.top, 44.dvs)
                    VStack(spacing: 20.dvs) {
                        NickNameTextFieldView(text: $createAccountModel.userName, isTextFieldDataNotValid: $createAccountModel.isUserNameValid, type: .userName)
                        MovaPasswordTextFieldView(text: $createAccountModel.password, type: .createPassword)
                        MovaPasswordTextFieldView(text: $createAccountModel.confirmPassword, type: .confirmPassword)
                    }
                    .padding([.leading, .trailing], 24)
                    .padding(.top, 28.dvs)
                    if !createAccountModel.errorMessage.isEmpty {
                        Text(createAccountModel.errorMessage)
                            .font(Font.Urbanist.SemiBold.size(of: 14))
                            .foregroundColor(Color(UIColor.MOVA.primary500))
                            .padding(.top, 20.dvs)
                    }
                    
                    Button("Sign up") {
                        createAccountModel.signUp()
                        if createAccountModel.isGoToInterestScreen {
                            coordinator.show(.interests)
                        }
                    }
                    .frame(height: 58.dvs, alignment: .center)
                    .buttonStyle(MovaButton(isButtonActive: createAccountModel.fieldsIsNotEmpty()))
                    .disabled(!createAccountModel.fieldsIsNotEmpty())
                    .padding([.leading, .trailing], 24)
                    .padding(.top, 28.dvs)
                    HStack {
                        Rectangle()
                            .frame(height: 1)
                            .padding(.leading, 34)
                            .foregroundColor(.CreateAccount.devider)
                        Text("or continue with")
                            .font(Font.Urbanist.SemiBold.size(of: 18.dhs))
                            .foregroundColor(Color(UIColor.MOVA.greyscale700))
                        Rectangle()
                            .frame(height: 1)
                            .padding(.trailing, 34)
                            .foregroundColor(.CreateAccount.devider)
                    }
                    .padding(.top, 28.dvs)
                    HStack {
                        AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "facebookLogo")
                        AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "googleLogo")
                            .padding([.leading, .trailing], 20.dhs)
                        AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "appleLogo")
                    }
                    .padding(.top, 28.dvs)
                    
                    HStack {
                        Text("Already have an account?")
                            .font(Font.Urbanist.Medium.size(of: 14))
                            .foregroundColor(Color(UIColor.MOVA.greyscale500))
                        Button(action: {
                            coordinator.show(.login)
                        }) {
                            Text("Sign in")
                                .font(Font.Urbanist.SemiBold.size(of: 14))
                                .foregroundColor(Color(UIColor.MOVA.primary500))
                        }
                    }
                    .padding(.top, 28.dvs)
                }
                PopupWithButtonView(viewType: .serviceIsTemporaryUnavailable, isDisplayed: $isSorryTopupDisplayed)
                    .navigationBarHidden(false)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: CustomBackButton())
            }
            .onTapGesture {
                UIApplication.shared.dismissKeyboard()
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
