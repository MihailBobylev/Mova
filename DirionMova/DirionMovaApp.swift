//
//  DirionMovaApp.swift
//  DirionMova
//
//  Created by Юрий Альт on 30.09.2022.
//

import SwiftUI

@main
struct DirionMovaApp: App {
    
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    
    var body: some Scene {
        WindowGroup {
            if storage.pinExists {
                PinView(viewModel: .init(pinFlow: .enter))
            } else {
                OnboardingView()
            }
        }
    }
}
