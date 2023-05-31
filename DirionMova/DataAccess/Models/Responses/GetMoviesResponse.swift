//
//  GetPopularMoviesResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

struct GetMoviesResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
