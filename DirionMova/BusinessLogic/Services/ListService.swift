//
//  ListServices.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/7/22.
//

import Moya

protocol ListServiceProtocol {
    func getListDetails(listId: String,
                        completion: @escaping (Result<ListGetDetailsResponse, MovaError>) -> Void)
    func removeMovie(listId: String,
                     sessionId: String,
                     movieId: String,
                     completion: @escaping(Result<RemoveAndAddMovieResponse, MovaError>) -> Void)
    func addMovie(listId: String,
                  sessionId: String,
                  movieId: String,
                  completion: @escaping(Result<RemoveAndAddMovieResponse, MovaError>) -> Void)
    func checkMovieStatus(movieID: String,
                          listId: String,
                          completion: @escaping(Result<CheckMovieStatusResponse, MovaError>) -> Void)
}

class ListService: ListServiceProtocol {
    let provider = MoyaProvider<ListAPI>()
    
    func getListDetails(listId: String,
                        completion: @escaping (Result<ListGetDetailsResponse, MovaError>) -> Void) {
        provider.makeRequest(
            .getDetails(listId: listId),
            completion: completion
        )
    }
    
    func removeMovie(listId: String,
                     sessionId: String,
                     movieId: String,
                     completion: @escaping (Result<RemoveAndAddMovieResponse, MovaError>) -> Void) {
        provider.makeRequest(
            .removeMovie(listId: listId, sessionId: sessionId, mediaId: movieId),
            completion: completion
        )
    }
    
    func addMovie(listId: String,
                  sessionId: String,
                  movieId: String,
                  completion: @escaping (Result<RemoveAndAddMovieResponse, MovaError>) -> Void) {
        provider.makeRequest(
            .addMovie(listId: listId, sessionId: sessionId, mediaId: movieId),
            completion: completion
        )
    }
    
    func checkMovieStatus(movieID: String,
                          listId: String,
                          completion: @escaping (Result<CheckMovieStatusResponse, MovaError>) -> Void) {
        provider.makeRequest(
            .checkMovieStatus(movieId: movieID, listId: listId),
            completion: completion
        )
    }
}
