//
//  GetMovieChangeListResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 05.12.2022.
//

struct GetMovieChangeListResponse: Decodable {
    let results: [ChangedMovie]
    let page: Int
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct ChangedMovie: Decodable {
    let id: Int
    let adult: Bool?
}
