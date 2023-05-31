//
//  MoviesAPI.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

import Foundation
import Moya

enum MoviesAPI {
    case getLatestMovie
    case getPopularMovies(page: Int)
    case getTopRatedMovies(page: Int)
    case getUpcomingMovies(page: Int)
    case getNowPlayingMovies(page: Int)
    case getMovieDetails(movieId: String)
    case getSimilarMovies(movieId: String, page: Int)
    case getMovieChangeList(page: Int)
}

extension MoviesAPI: TargetType {
    var baseURL: URL {
        return URL(string: ServerConstants.baseURL)!
    }
    
    var path: String {
        switch self {
        case .getLatestMovie:
            return "/movie/latest"
        case .getPopularMovies:
            return "/movie/popular"
        case .getTopRatedMovies:
            return "/movie/top_rated"
        case .getUpcomingMovies:
            return "/movie/upcoming"
        case .getNowPlayingMovies:
            return "/movie/now_playing"
        case .getMovieDetails(let movieId):
            return "/movie/\(movieId)"
        case .getSimilarMovies(let movieId, _):
            return "/movie/\(movieId)/similar"
        case .getMovieChangeList:
            return "/movie/changes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getLatestMovie:
            return .get
        case .getPopularMovies, .getTopRatedMovies, .getUpcomingMovies, .getNowPlayingMovies:
            return .get
        case .getMovieDetails, .getSimilarMovies, .getMovieChangeList:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getLatestMovie:
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en-US"
                ],
                encoding: URLEncoding.queryString
            )
        case .getPopularMovies(let page), .getTopRatedMovies(let page), .getUpcomingMovies(let page), .getNowPlayingMovies(let page), .getMovieChangeList(page: let page):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en-US",
                    "page": page
                ],
                encoding: URLEncoding.queryString
            )
        case .getMovieDetails:
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en-US",
                    "append_to_response": "release_dates,videos,credits"
                ],
                encoding: URLEncoding.queryString
            )
        case .getSimilarMovies(_, let page):
            return .requestParameters(
                parameters: [
                    "api_key": ServerConstants.apiKey,
                    "language": "en-US",
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
