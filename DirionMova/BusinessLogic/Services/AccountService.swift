//
//  AccountService.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/2/22.
//

import Moya

protocol AccountServiceProtocol {
    func getDetails(sessionId: String, completion: @escaping (Result<GetAccountDetailsResponse, MovaError>) -> Void)
    func getCreatedList(accountId: String, sessionId: String, completion: @escaping (Result<GetCreatedListResponse, MovaError>) -> Void)
    func createList(request: Data, sessionId: String, completion: @escaping (Result<CreateListResponse, MovaError>) -> Void)
}

class AccountService: AccountServiceProtocol {
    let provider = MoyaProvider<AccountAPI>()
    
    func getDetails(sessionId: String, completion: @escaping (Result<GetAccountDetailsResponse, MovaError>) -> Void) {
        provider.makeRequest(.getDetails(sessionId: sessionId),
                             completion: completion)
    }
    
    func getCreatedList(accountId: String, sessionId: String, completion: @escaping (Result<GetCreatedListResponse, MovaError>) -> Void) {
        provider.makeRequest(.getCreatedList(accountId: accountId, sessionId: sessionId),
                             completion: completion)
    }
    
    func createList(request: Data, sessionId: String, completion: @escaping (Result<CreateListResponse, MovaError>) -> Void) {
        provider.makeRequest(.createList(request: request, sessionId: sessionId),
                             completion: completion)
    }
}
