//
//  BiometricViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/17/22.
//

import SwiftUI
import LocalAuthentication

protocol BiometricViewIxResponder {
    func redirectHome() -> Void
}

class BiometricViewModel: ObservableObject {
    @Published var showBiometricAlert: Bool = false
    @Published var showSuccessMessage: Bool = false
    var ixResponder: BiometricViewIxResponder?
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    
    func checkBiometric() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Biometric authentication for `Mova`"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authError in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    if success {
                        self.showSuccess()
                    } else {
                        self.storage.isBiometryOn = false
                        debugPrint(authError?.localizedDescription)
                    }
                }
            }
        } else {
            self.storage.isBiometryOn = false
            showBiometricAlert = true
        }
    }
}

extension BiometricViewModel {
    private func showSuccess() {
        showSuccessMessage = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.showSuccessMessage = false
            self.storage.isBiometryOn = true
            self.ixResponder?.redirectHome()
        }
    }
    
 func openSettings() {
        if let bundleId = Bundle.main.bundleIdentifier {
            let url = URL(string: "App-Prefs:root")
            if let url = url {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
}
