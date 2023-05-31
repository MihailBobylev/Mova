//
//  ProfileViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.10.2022.
//

import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var isFullNameValid = true
    @Published var isNickNameValid = true
    @Published var isEmailValid = true
    @Published var isPhoneNumberValid = true
    
    @Published var fullName = ""
    @Published var nickName = ""
    @Published var email = ""
    @Published var phone = ""
    @Published var errorMessage = ""
    @Published var phoneCode = "61"
    @Published var countryFlag = "🇦🇺"
}

