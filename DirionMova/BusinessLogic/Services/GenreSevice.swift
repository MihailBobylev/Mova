//
//  GenreSevice.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 09.11.2022.
//

import Moya

protocol GenreServiceProtocol {
    func getGenreList(completion: @escaping(Result<GenreResponse, MovaError>) -> Void)
}

class GenreService: GenreServiceProtocol {
    let provider = MoyaProvider<GenreAPI>()
    
    func getGenreList(completion: @escaping (Result<GenreResponse, MovaError>) -> Void) {
        provider.makeRequest(.getGenreList, completion: completion)
    }
}
