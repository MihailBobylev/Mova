//
//  SearchAPI.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 02.11.2022.
//

import SwiftUI
import Moya

enum SearchAPI {
    case getSearchedMovies(query: String, page: Int)
}

extension SearchAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getSearchedMovies:
            return "/search/movie"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearchedMovies:
               return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSearchedMovies(let query, let page):
            return .requestParameters(parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en-US",
                    "query": query,
                    "page": page
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
