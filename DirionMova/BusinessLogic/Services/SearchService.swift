//
//  SearchService.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 02.11.2022.
//

import Moya

protocol SearchServiceProtocol {
    func getSearchedMovies(query: String, page: Int, completion: @escaping(Result<GetFindedMoviesResponse, MovaError>) -> Void)
}

class SearchService: SearchServiceProtocol {
    let provider = MoyaProvider<SearchAPI>()
    
    func getSearchedMovies(query: String, page: Int, completion: @escaping (Result<GetFindedMoviesResponse, MovaError>) -> Void) {
        provider.makeRequest(.getSearchedMovies(query: query, page: page), completion: completion)
    }
}
