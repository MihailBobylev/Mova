//
//  GetPopularMoviesResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

struct GetPopularMoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
}
