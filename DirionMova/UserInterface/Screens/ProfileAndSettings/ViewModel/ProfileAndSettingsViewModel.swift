//
//  ProfileAndSettingsViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 24.11.2022.
//

import Foundation
import SwiftUI

class ProfileAndSettingsViewModel: ObservableObject {
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    lazy var isGuest = storage.isGuest
    
    @Published var isPresentSheet = false
    @Published var dragOffset: CGSize = .zero
    @Published var bottomSheetTitle = "Log out"
    @Published var bottomSheetDesc = "Are you sure you want to log out?"
    @Published var isSubscribed = false
    @Published var image = UIImage() {
        didSet {
            storage.userImage = image
        }
    }
    @Published var fullName = ""
    @Published var email = ""
    
    func checkSubscribtion() -> Bool {
        storage.isSubscribed == true
    }
    
    func loadUserData() {
        if let _image = storage.userImage {
            image = _image
        } else {
            image = UIImage(named: "person") ?? UIImage()
        }
        
        if let _fullName = storage.fullName {
            fullName = _fullName
        }
        
        if let _email = storage.email {
            email = _email
        }
    }
}
