//
//  ListGetDetailsResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/7/22.
//

struct ListGetDetailsResponse: Decodable {
    let items: [ListGetDetailsItems]
}

struct ListGetDetailsItems: Decodable, Hashable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let mediaType: String
    let posterPath: String
    let title: String
    let voteAverage: Double
    enum CodingKeys: String, CodingKey {
        case adult, title
        case voteAverage = "vote_average"
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case id
        case genreIds = "genre_ids"
    }
}

