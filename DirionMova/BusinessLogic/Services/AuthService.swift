//
//  AuthService.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.10.2022.
//

import Moya

protocol AuthServiceProtocol {
    func createRequestToken(completion: @escaping (Result<AuthTokenResponse, MovaError>) -> Void)
    func validateWithLogin(request: Data, completion: @escaping (Result<AuthTokenResponse, MovaError>) -> Void)
    func createSession(token: String, completion: @escaping (Result<CreateSessionResponse, MovaError>) -> Void)
    func enterGuest(completion: @escaping(Result<EnterGuestResponse, MovaError>) -> Void)
}

class AuthService: AuthServiceProtocol {
    let provider = MoyaProvider<AuthAPI>()
    
    func createRequestToken(completion: @escaping (Result<AuthTokenResponse, MovaError>) -> Void) {
        provider.makeRequest(.createRequestToken, completion: completion)
    }
    
    func validateWithLogin(request: Data, completion: @escaping (Result<AuthTokenResponse, MovaError>) -> Void) {
        provider.makeRequest(.validateWithLogin(request: request), completion: completion)
    }
    
    func createSession(token: String, completion: @escaping (Result<CreateSessionResponse, MovaError>) -> Void) {
        provider.makeRequest(.createSession(token: token), completion: completion)
    }
    
    func enterGuest(completion: @escaping (Result<EnterGuestResponse, MovaError>) -> Void) {
        provider.makeRequest(.enterGuest, tryToUpdate: false, completion: completion)
    }
}

