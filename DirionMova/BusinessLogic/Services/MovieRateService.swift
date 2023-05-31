//
//  MovieRateService.swift
//  DirionMova
//
//  Created by Юрий Альт on 08.11.2022.
//

import Moya

protocol MovieRateServiceProtocol {
    func getAccountStates(movieId: Int, sessionId: String, completion: @escaping(Result<Response, MoyaError>) -> Void)
    func rateMovie(movieId: Int, sessionId: String, request: Data, completion: @escaping (Result<RateMovieResponse, MovaError>) -> Void)
    func deleteRating(movieId: Int, sessionId: String, completion: @escaping (Result<RateMovieResponse, MovaError>) -> Void)
}

class MovieRateServic: MovieRateServiceProtocol {
    let provider = MoyaProvider<RateAPI>()
    
    func getAccountStates(movieId: Int, sessionId: String, completion: @escaping(Result<Response, MoyaError>) -> Void) {
        provider.request(.getAccountStates(movieId: movieId, sessionId: sessionId), completion: completion)
    }
    
    func rateMovie(movieId: Int, sessionId: String, request: Data, completion: @escaping (Result<RateMovieResponse, MovaError>) -> Void) {
        provider.makeRequest(.rateMovie(movieId: movieId, sessionId: sessionId, request: request), completion: completion)
    }
    
    func deleteRating(movieId: Int, sessionId: String, completion: @escaping (Result<RateMovieResponse, MovaError>) -> Void) {
        provider.makeRequest(.deleteRating(movieId: movieId, sessionId: sessionId), completion: completion)
    }
}
