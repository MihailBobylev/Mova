//
//  PinViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/12/22.
//

import Foundation
import SwiftUI
import LocalAuthentication
import AVFoundation

protocol PinViewIxResponder {
    func showHome() -> Void
    func showBiometric() -> Void
    func showStartView() -> Void
    func popBack() -> Void
}

class PinViewModel: ObservableObject {
    
    var ixResponder: PinViewIxResponder?
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    private var pinAttempts = 3
    private var confirmPassword: String?
    @Published var accessDenied = false
    @Published var pinFlow: PinFlow
    @Published var errorMessage = ""
    @Published var isErrorVisible = false
    @Published var isButtonActive = false
    @Published var password = "" {
        didSet(oldValue) {
            if password.count > 4 {
                password = oldValue
            }
            if password.count == 4 {
                isButtonActive = true
            } else {
                isButtonActive = false
            }
        }
    }
    
    init(pinFlow: PinFlow) {
        self.pinFlow = pinFlow
    }
    
    func continueAction() {
        switch pinFlow {
        case .create:
            createPinAction()
        case .enter:
            enterPinAction()
        case .confirm:
            confirmPinAction()
        }
    }
    
    func backAction() {
        switch pinFlow {
        case .confirm:
            pinFlow = .create
            password = ""
        default:
            break
        }
    }
    
    func logoutAction() {
        ixResponder?.showStartView()
    }
    
    func checkBiometricAuthentication() {
        guard pinFlow == .enter else { return }
        guard storage.isBiometryOn ?? false else { return }
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Biometric authentication for `Mova`"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authError in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if success {
                        self.ixResponder?.showHome()
                    } else {
                        debugPrint(authError?.localizedDescription)
                    }
                }
            }
        } else { }
    }
}

extension PinViewModel {
    private func createPinAction() {
        confirmPassword = password
        pinFlow = .confirm
        password = ""
    }
    
    private func enterPinAction() {
        let isPinValid = storage.pinCode == password
        if isPinValid {
            hideErrorMessage()
            ixResponder?.showHome()
        } else {
            pinAttempts -= 1
            showErrorMessage()
        }
        
        guard pinAttempts > 0 else {
            accessDenied = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                self.logoutAction()
            }
            return
        }
    }
    
    private func confirmPinAction() {
        guard confirmPassword == password else {
            showErrorMessage()
            return
        }
        
        hideErrorMessage()
        storage.pinCode = password
        ixResponder?.showBiometric()
    }
    
    private func showErrorMessage() {
        makeVibration()
        errorMessage = pinFlow.getErrorMessage(attempts: pinAttempts)
        isErrorVisible = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.password = ""
            self.hideErrorMessage()
        }
    }
    
    private func hideErrorMessage() {
        isErrorVisible = false
    }
    
    private func makeVibration() {
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.error)
    }
}
