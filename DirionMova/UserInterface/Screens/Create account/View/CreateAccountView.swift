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
    
    var body: some View {
        ZStack {
            Color(UIColor.MOVA.white)
                .ignoresSafeArea()
            VStack {
                
                AppLogoView(size: 88)
                    .frame(width: 88, height: 88)
                    .padding(.top, 29)
                Text("Create Your Account")
                    .font(Font.Urbanist.Bold.size(of: 32))
                    .padding(.top, 43)
                VStack {
                    EmailTextFieldView(text: $createAccountModel.userName, isTextFieldDataNotValid: $createAccountModel.isUserNameValid)
                        .padding(.top, 8)
                    PasswordTextFieldView(text: $createAccountModel.password, isTextFieldDataNotValid: $createAccountModel.isPasswordValid)
                    PasswordTextFieldView(text: $createAccountModel.confirmPassword, isTextFieldDataNotValid: $createAccountModel.isConfirmPasswordValid)
                }
                .padding([.leading, .trailing], 24)
                
                Text(createAccountModel.errorMessage)
                    .font(Font.Urbanist.SemiBold.size(of: 14))
                    .foregroundColor(Color(UIColor.MOVA.primary500))
                    .padding(.top, 20)
                
                Button("Sign up") {
                    createAccountModel.signUp()
                    if createAccountModel.isGoToInterestScreen {
                        coordinator.show(.interests)
                    }
                }
                .frame(height: 58, alignment: .center)
                .buttonStyle(MovaButton())
                .padding([.top, .leading, .trailing], 24)

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .padding(.leading, 24)
                        .foregroundColor(Color(UIColor.MOVA.greyscale200))
                    Text("or continue with")
                        .font(Font.Urbanist.SemiBold.size(of: 18))
                        .foregroundColor(Color(UIColor.MOVA.greyscale700))
                    Rectangle()
                        .frame(height: 1)
                        .padding(.trailing, 24)
                        .foregroundColor(Color(UIColor.MOVA.greyscale200))
                }
                .padding(.top, 13)
                HStack {
                    AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "facebookLogo")
                    AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "googleLogo")
                        .padding([.leading, .trailing], 20)
                    AuthSocialNetworkButtonView(action: { isSorryTopupDisplayed.toggle() }, imageName: "appleLogo")
                }
                .padding(.top, 20)
                
                HStack {
                    Text("Already have an account?")
                        .font(Font.Urbanist.Medium.size(of: 14))
                        .foregroundColor(Color(UIColor.MOVA.greyscale500))
                    Button(action: {
                        
                        
                    }) {
                        Text("Sign in")
                            .font(Font.Urbanist.SemiBold.size(of: 14))
                            .foregroundColor(Color(UIColor.MOVA.primary500))
                    }
                }
                .padding(.top, 12)
            }
            SorryPopupView(isDisplayed: $isSorryTopupDisplayed)
            
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
        }
        
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
