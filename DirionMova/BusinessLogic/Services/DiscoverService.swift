//
//  DiscoverService.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 08.11.2022.
//

import Moya

protocol DiscoverServiceProtocol {
    func getDiscoverMovies(params: [String : Any], completion: @escaping(Result<GetFindedMoviesResponse, MovaError>) -> Void)
}

class DiscoverService: DiscoverServiceProtocol {
    let provider = MoyaProvider<DiscoverAPI>()
    
    func getDiscoverMovies(params: [String : Any], completion: @escaping (Result<GetFindedMoviesResponse, MovaError>) -> Void) {
        provider.makeRequest(.getDiscoverMovies(params: params), completion: completion)
    }
}
