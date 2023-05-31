//
//  OnboardingViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/6/22.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var modelData: [OnboardingModel] = OnboardingModel.allCases
    
    private var storage: CredentialsStorage = CredentialStorageImplementation()

    func turnOffNextLaunchOnboarding() {
        storage.isFirstLaunch.toggle()
    }
}
