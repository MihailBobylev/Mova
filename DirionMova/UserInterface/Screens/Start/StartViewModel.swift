//
//  StartViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.10.2022.
//

import Foundation

class StartViewModel: ObservableObject {
    @Published var isSorryTopupDisplayed = false
    
    private let service = AuthService()
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    var delegate: StartViewIxResponder?
    
    func enterGuest() {
        service.enterGuest { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.storage.sessionID = data.guestSessionId
                self.storage.guestSessionLastUpdate = Date()
                self.delegate?.redirectHomeScreen()
            case .failure(let error):
                print(error)
                self.isSorryTopupDisplayed.toggle()
            }
        }
    }
}
