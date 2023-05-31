//
//  ReviewSummaryViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 21.12.2022.
//

import Foundation

class ReviewSummaryViewModel: ObservableObject {
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    @Published var isDisplaySuccessPopUp = false
    
    func makeSubscribed() {
        storage.isSubscribed = true
    }
}
