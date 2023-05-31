//
//  AuthUseCase.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/1/22.
//

import Foundation
import Moya

protocol AuthUseCase {
    func loginAndCreateSession(username: String,
                                password: String,
                                      completion: @escaping (Result<String, MovaError>) -> Void)
}

final class DefaultAuthUseCase: AuthUseCase {
    private let authAPI: AuthServiceProtocol = AuthService()
    private var storage: CredentialsStorage = CredentialStorageImplementation()

    
    func loginAndCreateSession(username: String,
                                      password: String,
                                      completion: @escaping (Result<String, MovaError>) -> Void) {
        authAPI.createRequestToken { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.validateLogin(username: username,
                                   password: password,
                                   requestToken: data.requestToken,
                                   completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func validateLogin(username: String,
                               password: String,
                               requestToken: String,
                               completion: @escaping (Result<String, MovaError>) -> Void) {
        let request = ValidateWithLoginRequest(userName: username,
                                               password: password,
                                               requestToken: requestToken)
        guard let requestData = try? JSONEncoder().encode(request) else { return }
        
        authAPI.validateWithLogin(request: requestData) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                    self.storage.store(username: username, password: password)
                    self.createSession(token: data.requestToken, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func createSession(token: String, completion: @escaping (Result<String, MovaError>) -> Void) {
        authAPI.createSession(token: token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                    self.storage.sessionID = data.sessionId
                    completion(.success(data.sessionId))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
