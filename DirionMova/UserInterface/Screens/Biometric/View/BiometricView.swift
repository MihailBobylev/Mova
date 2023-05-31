//
//  BiometricView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/17/22.
//

import SwiftUI

struct BiometricView: View {
    @ObservedObject var viewModel: BiometricViewModel
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        ZStack {
            Color(Color.Biometric.background)
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Text(verbatim: "Set Your Biometric")
                            .font(Font.Urbanist.Bold.size(of: 24.dfs))
                    }
                }
            VStack {
                Spacer()
                topDescription
                Spacer()
                Image("ic_biometric")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 228.dhs, height: 236.dvs)
                Spacer()
                bottomDescription
                Spacer()
                HStack {
                    skipButton
                    continueButton
                }
                .padding(.horizontal, 24.dhs)
                .padding(.bottom, 48.dvs)
            }
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .opacity(viewModel.showSuccessMessage ? 1 : 0)
                .animation(.easeIn(duration: 0.2))
            LoadingPopupView(isDisplayed: $viewModel.showSuccessMessage, type: .success)
            PopupWithButtonView(viewType: .biometricTurnedOff,
                                isDisplayed: $viewModel.showBiometricAlert,
                                buttonText: "Settings", customAction: viewModel.openSettings)
        }.navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.ixResponder = self
        }
    }
}

extension BiometricView {
    
    var topDescription: some View {
        Text("Add a biometric to make your account more secure")
            .font(Font.Urbanist.Regular.size(of: 18.dfs))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24.dhs)
    }
    
    var bottomDescription: some View {
        Text("Please press to continue buttom to start by biometric initialization")
            .font(Font.Urbanist.Regular.size(of: 18.dfs))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 24.dhs)
    }
    
    var skipButton: some View {
        Button(action: skipAction) {
            Text("Skip")
        }.buttonStyle(GrayButton())
            .frame(height: 58.dvs)
    }
    
    var continueButton: some View {
        Button {
            viewModel.checkBiometric()
        } label: {
            Text("Continue")
        }.buttonStyle(MovaButton())
            .frame(height: 58.dvs)
    }
}

extension BiometricView {
    private func skipAction() {
        redirectHome()
    }
}

extension BiometricView: BiometricViewIxResponder {
    func redirectHome() {
        coordinator.show(.home)
    }
}

struct BiometricView_Previews: PreviewProvider {
    static var previews: some View {
        BiometricView(viewModel: BiometricViewModel())
    }
}


