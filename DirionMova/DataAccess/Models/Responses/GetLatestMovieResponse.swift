//
//  GetLatestMovieResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 24.10.2022.
//

struct GetLatestMovieResponse: Decodable {
    let adult: Bool
    let budget: Int
    let genres: [Int]
    let homepage: String
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Int
    let posterPath: String
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case adult
        case budget
        case genres
        case homepage
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case title
    }
}
