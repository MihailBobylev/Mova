//
//  GetFindedMovieResponse.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 03.11.2022.
//

struct GetFindedMoviesResponse: Decodable {
    let page: Int
    let results: [FindedMovie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
