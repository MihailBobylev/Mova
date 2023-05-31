//
//  ListAPI.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/7/22.
//

import Foundation
import Moya

enum ListAPI {
    case getDetails(listId: String)
    case removeMovie(listId: String, sessionId: String, mediaId: String)
    case addMovie(listId: String, sessionId: String, mediaId: String)
    case checkMovieStatus(movieId: String, listId: String)
}

extension ListAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getDetails(let listId):
            return "/list/\(listId)"
        case .removeMovie(let listId, _, _):
            return "/list/\(listId)/remove_item"
        case .addMovie(let listId, _, _):
            return "/list/\(listId)/add_item"
        case .checkMovieStatus(_, let listId):
            return "/list/\(listId)/item_status"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getDetails, .checkMovieStatus:
            return .get
        case .removeMovie, .addMovie:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getDetails:
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en_US"
                ],
                encoding: URLEncoding.queryString)
        case .removeMovie(_, let sessionId, let mediaId), .addMovie(_, let sessionId, let mediaId):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "session_id": sessionId,
                    "media_id": mediaId
                ],
                encoding: URLEncoding.queryString)
        case .checkMovieStatus(let movieId, _):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "movie_id": movieId
                ],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        ServerConstants.httpHeaders
    }
}
