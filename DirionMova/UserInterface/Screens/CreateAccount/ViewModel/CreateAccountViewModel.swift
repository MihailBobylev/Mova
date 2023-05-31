//
//  CreateAccountViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.10.2022.
//

import SwiftUI
import Foundation

class CreateAccountViewModel: ObservableObject {
    @Published var isUserNameValid = true
    @Published var isPasswordValid = true
    @Published var isConfirmPasswordValid = true
    @Published var isGoToInterestScreen = false
    @Published var userName = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage = ""
    
    func fieldsIsNotEmpty() -> Bool {
        guard userName.count > 0 else {
            return false
        }
        guard password.count > 0 else {
            return false
        }
        guard confirmPassword.count > 0 else {
            return false
        }
        return true
    }
    
    func signUp() {
        guard userName.count > 0 else {
            errorMessage = "Username is not valid"
            isUserNameValid = false
            return
        }
        guard password.count > 0 else {
            errorMessage = "Password not valid"
            isPasswordValid = false
            return
        }
        guard password == confirmPassword else {
            errorMessage = "Password don't mutch"
            isConfirmPasswordValid = false
            return
        }
        errorMessage = ""
        isGoToInterestScreen = true
    }
}

