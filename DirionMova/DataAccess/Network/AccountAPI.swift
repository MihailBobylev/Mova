//
//  AccountAPI.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/2/22.
//

import Foundation
import Moya

enum AccountAPI {
    case getDetails(sessionId: String)
    case getCreatedList(accountId: String, sessionId: String)
    case createList(request: Data, sessionId: String)
}

extension AccountAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDetails:
            return "/account"
        case .getCreatedList(let accountId, _):
            return "/account/\(accountId)/lists"
        case .createList:
            return "/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDetails, .getCreatedList:
            return .get
        case .createList:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDetails(let sessionId):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "session_id": sessionId
                ],
                encoding: URLEncoding.queryString
            )
        case .getCreatedList(_, let sessionId):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en_US",
                    "session_id": sessionId,
                ],
                encoding: URLEncoding.queryString
            )
        case .createList(let request, let sessionId):
            return .requestCompositeData(
                bodyData: request,
                urlParameters: [
                    "api_key": ServerConstants.apiKey,
                    "session_id": sessionId
                ]
            )
        }
    }
    
    var headers: [String : String]? {
        ServerConstants.httpHeaders
    }
}
