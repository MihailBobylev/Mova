//
//  EditProfileViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/7/22.
//

import Foundation
import SwiftUI

class EditProfileViewModel: ObservableObject {
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    
    @Published var image = UIImage()
    @Published var fullNameText = ""
    @Published var nickNameText = ""
    @Published var emailText = ""
    @Published var phoneNumberText = ""
    @Published var genderType = ""
    @Published var phoneCode = "61"
    @Published var countryFlag = "🇦🇺"
    @Published var countryName = ""
    
    func fieldsValid() -> Bool { return true }
    
    func saveLocal() {
        storage.userImage = image
        storage.fullName = fullNameText
        storage.email = emailText
    }
    
    func loadUserData() {
        if let _image = self.storage.userImage {
            self.image = _image
        } else {
            self.image = UIImage(named: "person") ?? UIImage()
        }
        
        if let _fullName = self.storage.fullName {
            self.fullNameText = _fullName
        }
        
        if let _email = self.storage.email {
            self.emailText = _email
        }
    }
}
