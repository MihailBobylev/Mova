//
//  PinView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/11/22.
//

import SwiftUI

struct PinView: View {
    @ObservedObject var viewModel: PinViewModel
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        ZStack {
            Color(Color.Login.background)
                .ignoresSafeArea()
            VStack {
                PinHeaderView(viewModel: viewModel)
                    .padding(.leading, 24.dhs)
                Spacer()
                PinDescriptionView(viewModel: viewModel)
                PinTextBox(password: $viewModel.password,
                           isError: $viewModel.isErrorVisible,
                           isSecure: true)
                Spacer()
                if viewModel.isErrorVisible {
                    PinErrorDescriptionView(viewModel: viewModel)
                }
                Spacer()
                PinContinueButtonView(viewModel: viewModel)
                if viewModel.pinFlow == .enter {
                    PinCustomKeyboard(text: $viewModel.password,
                                      customKey: .custom("Log Out"),
                                      customAction: viewModel.logoutAction)
                    .frame(height: 260.dvs)
                } else {
                    PinCustomKeyboard(text: $viewModel.password,
                                      customKey: .custom("Skip"),
                                      customAction: skipAction)
                    .frame(height: 260.dvs)
                }
            }
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .opacity(viewModel.accessDenied ? 1 : 0)
                .animation(.easeIn(duration: 0.2))
            LoadingPopupView(isDisplayed: $viewModel.accessDenied, type: .denied)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
        .onAppear {
            viewModel.ixResponder = self
            viewModel.checkBiometricAuthentication()
        }
    }
}

//MARK: - Subviews
struct PinHeaderView: View {
    @ObservedObject var viewModel: PinViewModel
    
    var body: some View {
        HStack {
            if viewModel.pinFlow == .confirm {
                Button(action: viewModel.backAction) {
                    Image("arrowLeftLight")
                        .frame(width: 28, height: 28)
                }
            }
            Text(verbatim: viewModel.pinFlow.title)
                .font(Font.Urbanist.Bold.size(of: 24.dfs))
            Spacer()
        }
    }
}

struct PinDescriptionView: View {
    @ObservedObject var viewModel: PinViewModel
    
    var body: some View {
        Text(viewModel.pinFlow.description)
            .font(Font.Urbanist.Regular.size(of: 18.dfs))
            .foregroundColor(Color.Pin.pinDescriptionColor)
            .multilineTextAlignment(.center)
            .padding(.bottom, 30.dvs)
            .padding([.leading, .trailing], 24.dhs)
    }
}

struct PinErrorDescriptionView: View {
    @ObservedObject var viewModel: PinViewModel
    
    var body: some View {
        Text(viewModel.errorMessage)
            .font(Font.Urbanist.Medium.size(of: 16.dfs))
            .foregroundColor(Color.Pin.errorMessageColor)
            .multilineTextAlignment(.center)
            .opacity(viewModel.isErrorVisible ? 1 : 0)
    }
}

struct PinContinueButtonView: View {
    @ObservedObject var viewModel: PinViewModel
    
    var body: some View {
        Button("Continue", action: viewModel.continueAction)
            .frame(height: 58.dvs, alignment: .center)
            .buttonStyle(MovaButton(isButtonActive: viewModel.isButtonActive))
            .padding([.leading, .trailing], 24.dhs)
            .padding([.top, .bottom], 24.dvs)
            .allowsHitTesting(viewModel.password.count >= 4)
            .animation(.easeInOut)
    }
}

//MARK: - Actions
extension PinView {
    private func skipAction() {
        coordinator.show(.home)
    }
}

struct PinView_Previews: PreviewProvider {
    static var previews: some View {
        PinView(viewModel: .init(pinFlow: .enter))
    }
}

//MARK: - IxResponder
extension PinView: PinViewIxResponder {
    func showHome() {
        coordinator.show(.home)
    }
    
    func showStartView() {
        coordinator.logout()
    }
    
    func popBack() {
        coordinator.pop()
    }
    
    func showBiometric() {
        coordinator.show(.biometric)
    }
}
