//
//  Moya+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/3/22.
//

import Foundation
import Moya

extension MoyaProviderType {
    
    func makeRequest<D: Decodable>(_ target: Target, callbackQueue: DispatchQueue? = .none, tryToUpdate: Bool = true, progress: Moya.ProgressBlock? = .none, completion: @escaping (Result<D, MovaError>) -> Void) {
        let storage = CredentialStorageImplementation()
        let service = AuthService()
        if tryToUpdate, let lastUpdate = storage.guestSessionLastUpdate {
            let diff = Calendar.current.dateComponents([.hour], from: lastUpdate, to: Date()).hour!
            if diff >= 24 {
                service.enterGuest { result in
                    switch result {
                    case .success(let data):
                        storage.sessionID = data.guestSessionId
                        storage.guestSessionLastUpdate = Date()
                        self.makeRequest(target, tryToUpdate: false, completion: completion)
                    case .failure(let error):
                        completion(.failure(MovaError(statusCode: error.statusCode.rawValue, statusMessage: error.statusMessage)))
                    }
                }
            } else {
                privateMakeRequest(
                    target,
                    callbackQueue: callbackQueue,
                    progress: progress,
                    completion: completion)
            }
        } else {
            privateMakeRequest(
                target,
                callbackQueue: callbackQueue,
                progress: progress,
                completion: completion)
        }
    }
}

extension MoyaProviderType {
    @discardableResult
    private func privateMakeRequest<D: Decodable>(_ target: Target, callbackQueue: DispatchQueue? = .none, progress: Moya.ProgressBlock? = .none, completion: @escaping (Result<D, MovaError>) -> Void) -> Cancellable {
        return self.request(target, callbackQueue: callbackQueue, progress: progress) { result in
            switch result {
            case .success(let response):
                if let request = response.request {
                    print("\(request.cURL(pretty: true))")
                }
                if (200 ... 299).contains(response.statusCode) {
                    do {
                        let res = try response.map(D.self)
                        completion(.success(res))
                    } catch let mappingError {
                        print(mappingError)
                        let error = MovaError.requestParsingFailure()
                        completion(.failure(error))
                    }
                } else {
                    var error: MovaError
                    do {
                        error = try response.map(MovaError.self)
                    } catch let mappingError {
                        debugPrint(mappingError)
                        error = MovaError.requestParsingFailure()
                    }
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(MovaError(statusCode: error.errorCode, statusMessage: error.errorDescription)))
            }
        }
    }
}
