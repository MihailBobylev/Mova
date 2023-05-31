//
//  Film.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

struct Movie: Decodable, Hashable {
    let posterPath: String
    let backdropPath: String?
    let genreIds: [Int]
    let originalTitle: String
    let title: String
    let voteAverage: Double
    let id: Int
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case originalTitle = "original_title"
        case title
        case voteAverage = "vote_average"
        case id
    }
    
    func getGenreNames() -> String {
        let genreIDs = genreIds
        var arrayOfGenres: [String] = []
        genreIDs.forEach { genreId in
            if let genreString = Genres(rawValue: genreId)?.genreName {
                arrayOfGenres.append(genreString)
            }
        }
        let stringFromArray = arrayOfGenres.joined(separator: ", ")
        return stringFromArray
    }
}
