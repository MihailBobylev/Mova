//
//  AuthAPI.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.10.2022.
//

import Foundation
import Moya

enum AuthAPI {
    case createRequestToken
    case createSession(token: String)
    case validateWithLogin(request: Data)
    case enterGuest
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .createRequestToken:
            return "/authentication/token/new"
        case .validateWithLogin:
            return "/authentication/token/validate_with_login"
        case .createSession:
            return "/authentication/session/new"
        case .enterGuest:
            return "/authentication/guest_session/new"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createRequestToken:
            return .get
        case .validateWithLogin, .createSession:
            return .post
        case .enterGuest:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .createRequestToken:
            return .requestParameters(
                parameters: ["api_key": ServerConstants.apiKey],
                encoding: URLEncoding.queryString
            )
        case .validateWithLogin(let request):
            return .requestCompositeData(
                bodyData: request,
                urlParameters: ["api_key": ServerConstants.apiKey]
            )
        case .createSession(let token):
            return .requestParameters(
                parameters: [
                "api_key" : ServerConstants.apiKey,
                "request_token": token,
                ],
                encoding: URLEncoding.queryString)
        case .enterGuest:
            return .requestParameters(
                parameters: [
                "api_key" : ServerConstants.apiKey,
                ],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        let headers = ServerConstants.httpHeaders
        return headers
    }
}

