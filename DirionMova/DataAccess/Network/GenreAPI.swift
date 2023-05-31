//
//  GenreAPI.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 09.11.2022.
//

import Foundation
import Moya

enum GenreAPI {
    case getGenreList
}

extension GenreAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getGenreList:
            return "/genre/movie/list"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getGenreList:
               return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getGenreList:
            return .requestParameters(parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en-US",
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
