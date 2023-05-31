//
//  EnterNewPasswordViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 02.12.2022.
//

import SwiftUI

class EnterNewPasswordViewModel: ObservableObject {
    //MARK: - Binding Properties
    @Published var password = ""
    @Published var confirmationPassword = ""
    
    //MARK: - Public Methods
    func getPopUpButtonState() -> Bool {
        guard password.count >= 3 && confirmationPassword.count >= 3 && password == confirmationPassword else {
            return false
        }
        return true
    }
}
