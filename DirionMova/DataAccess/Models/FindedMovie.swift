//
//  FindedMovie.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 03.11.2022.
//

struct FindedMovie: Decodable, Hashable {
    
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalTitle: String
    let posterPath: String?
    let title: String
    let voteAverage: Double
    
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case title
        case voteAverage = "vote_average"
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
