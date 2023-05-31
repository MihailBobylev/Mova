//
//  RateAPI.swift
//  DirionMova
//
//  Created by Юрий Альт on 08.11.2022.
//

import Foundation
import Moya

enum RateAPI {
    case getAccountStates(movieId: Int, sessionId: String)
    case rateMovie(movieId: Int, sessionId: String, request: Data)
    case deleteRating(movieId: Int, sessionId: String)
}

extension RateAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getAccountStates(let movieId, _):
            return "/movie/\(movieId)/account_states"
        case .rateMovie(let movieId, _, _):
            return "/movie/\(movieId)/rating"
        case .deleteRating(let movieId, _):
            return "/movie/\(movieId)/rating"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getAccountStates:
            return .get
        case .rateMovie:
            return .post
        case .deleteRating:
            return .delete
        }
    }
    
    var task: Task {
        switch self {
        case .getAccountStates(_, let sessionId):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "session_id": sessionId
                ],
                encoding: URLEncoding.queryString
            )
        case .rateMovie(_, let sessionId, let request):
            return .requestCompositeData(
                bodyData: request,
                urlParameters: [
                    "api_key": ServerConstants.apiKey,
                    "session_id": sessionId
                ]
            )
        case .deleteRating(_, let sessionId):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "session_id": sessionId
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        let headers = ServerConstants.httpHeaders
        return headers
    }
}
