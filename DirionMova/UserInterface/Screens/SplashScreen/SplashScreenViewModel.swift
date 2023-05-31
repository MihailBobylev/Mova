//
//  SplashScreenViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/24/22.
//

import Foundation

class SplashScreenViewModel {
    private let service = AuthService()
    private let storage = CredentialStorageImplementation()
    func renewGuestSession() {
        guard let lastUpdate = storage.guestSessionLastUpdate else { return }
        let diff = Calendar.current.dateComponents([.hour], from: lastUpdate, to: Date()).hour!
        debugPrint("Updated \(diff) hours ago")
        if diff >= 24 {
            service.enterGuest { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let data):
                    self.storage.guestSessionLastUpdate = Date()
                    self.storage.sessionID = data.guestSessionId
                case .failure(let error):
                    debugPrint("failed with \(error)")
                }
            }
        }
    }
}
