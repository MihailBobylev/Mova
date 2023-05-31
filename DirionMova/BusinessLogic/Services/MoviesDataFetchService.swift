//
//  MoviesDataFetchService.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

import Moya

protocol MoviesDataFetchServiceProtocol {
    func getLatestMovie(completion: @escaping (Result<Response, MoyaError>) -> Void)
    func getMovies(type: MoviesGroupType, page: Int, completion: @escaping (Result<GetMoviesResponse, MovaError>) -> Void)
    func getMovieDetails(movieID: String, completion: @escaping (Result<MovieDetailsResponse, MovaError>) -> Void)
    func getSimilarMovies(movieID: String, page: Int, completion: @escaping(Result<GetMoviesResponse, MovaError>) -> Void)
    func getMoviesChangeList(page: Int, completion: @escaping(Result<GetMovieChangeListResponse, MovaError>) -> Void)
    func getNotificationMovieDetails(movieID: String, completion: @escaping (Result<NotificationMovieDetailsResponse, MovaError>) -> Void)
}

class MoviesDataFetchService: MoviesDataFetchServiceProtocol {
    let provider = MoyaProvider<MoviesAPI>()
    
    func getLatestMovie(completion: @escaping (Result<Response, MoyaError>) -> Void) {
        provider.request(.getLatestMovie, completion: completion)
    }
    
    func getMovies(type: MoviesGroupType, page: Int, completion: @escaping (Result<GetMoviesResponse, MovaError>) -> Void) {
        switch type {
        case .popularMovies:
            provider.makeRequest(.getPopularMovies(page: page), completion: completion)
        case .topRatedMovies:
            provider.makeRequest(.getTopRatedMovies(page: page), completion: completion)
        case .upcomingMovies:
            provider.makeRequest(.getUpcomingMovies(page: page), completion: completion)
        case .nowPlayingMovies:
            provider.makeRequest(.getNowPlayingMovies(page: page), completion: completion)
        }
    }
    
    func getMovieDetails(movieID: String, completion: @escaping (Result<MovieDetailsResponse, MovaError>) -> Void) {
        provider.makeRequest(.getMovieDetails(movieId: movieID), completion: completion)
    }
    
    func getSimilarMovies(movieID: String, page: Int, completion: @escaping (Result<GetMoviesResponse, MovaError>) -> Void) {
        provider.makeRequest(.getSimilarMovies(movieId: movieID, page: page), completion: completion)
    }
    
    func getMoviesChangeList(page: Int, completion: @escaping (Result<GetMovieChangeListResponse, MovaError>) -> Void) {
        provider.makeRequest(.getMovieChangeList(page: page), completion: completion)
    }
    
    func getNotificationMovieDetails(movieID: String, completion: @escaping (Result<NotificationMovieDetailsResponse, MovaError>) -> Void) {
        provider.makeRequest(.getMovieDetails(movieId: movieID), completion: completion)
    }
}
