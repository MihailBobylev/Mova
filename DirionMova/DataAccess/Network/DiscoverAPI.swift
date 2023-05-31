//
//  DiscoverAPI.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 08.11.2022.
//

import Moya

enum DiscoverAPI {
    case getDiscoverMovies(params: [String : Any])
}

extension DiscoverAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDiscoverMovies:
            return "/discover/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDiscoverMovies:
               return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDiscoverMovies(let params):
            return .requestParameters(
                parameters: params,
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        let headers = ServerConstants.httpHeaders
        return headers
    }
}
