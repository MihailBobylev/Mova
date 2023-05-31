//
//  AccountUseCase.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/2/22.
//

import Foundation
import Moya

protocol AccountUseCase {
    func getCreatedList(sessionId: String, completion: @escaping (Result<Bool, MovaError>) -> Void)
    func getAccountDetails(sessionId: String, completion: @escaping (Result<String, MovaError>) -> Void)
}

final class DefaultAccountUseCase: AccountUseCase {
    private let accountAPI: AccountServiceProtocol = AccountService()
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    
    func getCreatedList(sessionId: String,
                        completion: @escaping (Result<Bool, MovaError>) -> Void) {
        getAccountDetails(sessionId: sessionId) { result in
            switch result {
            case .success(let accountId):
                self.callCreatedList(sessionId: sessionId,
                                    accountId: accountId,
                                    completion: completion)
            case .failure(let error):
                debugPrint("+++getCreatedList failure: ",error)
                completion(.failure(error))
            }
        }
    }
    
    func getAccountDetails(sessionId: String,
                           completion: @escaping (Result<String, MovaError>) -> Void) {
        
        accountAPI.getDetails(sessionId: sessionId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.storage.accountID = response.id.stringValue
                completion(.success(response.id.stringValue))
            case .failure(let error):
                debugPrint("Is it inside getAccountDetails")
                debugPrint("+++getDetails failure: ", error)
                completion(.failure(error))
            }
        }
    }
}

extension DefaultAccountUseCase {
    //MARK: - Helper functions
    private func callCreatedList(sessionId: String,
                                 accountId: String,
                                 completion: @escaping (Result<Bool, MovaError>) -> Void) {
        
        accountAPI.getCreatedList(accountId: accountId,
                                  sessionId: sessionId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                if let list = response.results.first {
                    self.storage.listId = list.id.stringValue
                    completion(.success(true))
                } else {
                    self.createList(sessionId: sessionId,
                                    completion: completion)
                }
            case .failure(let error):
                debugPrint("+++callCreatedList failure: ",error)
                completion(.failure(error))
            }
        }
    }
    
    private func createList(sessionId: String,
                            completion: @escaping (Result<Bool, MovaError>) -> Void) {
        let request = CreateListRequest.buildDefaultRequest()
        
        guard let requestData = try? JSONEncoder().encode(request) else {
            completion(.failure(MovaError.requestParsingFailure()))
            return
        }
            
        accountAPI.createList(request: requestData, sessionId: sessionId) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.storage.listId = response.listId.stringValue
                completion(.success(response.success))
            case .failure(let error):
                debugPrint("+++createList failure: ",error)
                completion(.failure(error))
            }
        }
    }
}
