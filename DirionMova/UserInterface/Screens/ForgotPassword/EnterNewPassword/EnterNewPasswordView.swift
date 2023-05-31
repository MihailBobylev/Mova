//
//  EnterNewPasswordView.swift
//  DirionMova
//
//  Created by Юрий Альт on 01.12.2022.
//

import SwiftUI

//MARK: - Root View
struct EnterNewPasswordView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @ObservedObject var viewModel = EnterNewPasswordViewModel()
    @State private var isPopUpDisplayed = false
    @State private var rememberChecked = false
    var body: some View {
        ZStack {
            Color(Color.EnterNewPassword.background)
                .ignoresSafeArea()
            VStack {
                ForgotPasswordHeaderView(titleText: "Create New Password")
                    .padding(.top, 34.dvs)
                Image("createPass")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 360.dhs, height: 257.dvs)
                    .padding(.top, 40.dvs)
                HStack {
                    Text("Create Your New Password")
                        .font(.Urbanist.Medium.size(of: 18.dfs))
                        .foregroundColor(.EnterNewPassword.topInfoText)
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(.top, 40.dvs)
                MovaPasswordTextFieldView(text: $viewModel.password, type: .createPassword)
                    .padding(.top, 24.dvs)
                MovaPasswordTextFieldView(text: $viewModel.confirmationPassword, type: .confirmPassword)
                    .padding(.top, 24.dvs)
                HStack(spacing: 12.dhs) {
                    CheckBoxView(checked: $rememberChecked)
                    Text("Remember me")
                        .font(.Urbanist.Medium.size(of: 14.dfs))
                }
                .padding(.top, 24.dvs)
                RedMovaButton(
                    action: { setupTransitionToPin() },
                    isActive: viewModel.getPopUpButtonState(),
                    text: "Continue"
                )
                .frame(height: 58.dvs)
                .padding(.top, 87.dvs)
                Spacer()
            }
            .padding(.horizontal, 24.dhs)
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .opacity(isPopUpDisplayed ? 1 : 0)
                .animation(.easeIn(duration: 0.2))
            LoadingPopupView(isDisplayed: $isPopUpDisplayed, type: .success)
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
    
    private func setupTransitionToPin() {
        isPopUpDisplayed = true
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.success)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isPopUpDisplayed = false
            self.coordinator.show(.pin(flow: .create))
        }
    }
}

//MARK: - Preview
struct EnterNewPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EnterNewPasswordView()
    }
}
