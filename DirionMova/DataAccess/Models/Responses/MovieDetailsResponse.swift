//
//  MovieDetailsResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/20/22.
//
import Foundation

struct MovieDetailsResponse: Decodable {
    let uuid = UUID()
    
    let adult: Bool
    let backdropPath: String?
    let genres: [Genre]
    let id: Int?
    let imdbId: String?
    let originalTitle: String?
    let overview: String?
    let posterPath: String?
    let productionCountries: [ProdCountries]?
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let releaseDates: ReleaseDates
    let credits: MovieActorsResponse
    let videos: MovieVideoResponse?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genres
        case id
        case imdbId = "imdb_id"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDates = "release_dates"
        case credits
        case videos
    }
}

struct ProdCountries: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}

struct ReleaseDates: Decodable {
    let results: [ReleaseDataData]
}

struct ReleaseDataData: Decodable {
    let iso31661: String
    let releaseDates: [ReleaseDate]
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case releaseDates = "release_dates"
    }
}

struct ReleaseDate: Decodable {
    let certification: String?
}

struct MovieActorsResponse: Decodable {
    let cast: [Cast]
    let crew: [Crew]
}

struct Cast: Decodable {
    let originalName: String?
    let knownForDepartment: String?
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

struct Crew: Decodable {
    let originalName: String?
    let profilePath: String?
    let job: String?
    
    enum CodingKeys: String, CodingKey {
        case job
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
}

struct MovieVideoResponse: Decodable {
    let results: [MovieVideoResult]?
}

struct MovieVideoResult: Decodable {
    let name: String?
    let key: String?
    let site: String?
}

extension MovieDetailsResponse {
    
    var getReleaseYearString: String {
        releaseDate.getYearString
    }
    
    var getFirstProductionCountry: String {
        return productionCountries?.first?.name ?? ""
    }
    
    var getImdbURL: URL? {
        return URL(string: ServerConstants.descriptionBaseURL + (imdbId ?? ""))
    }
    
    var getCertificate: String {
        return releaseDates.results.filter { $0.iso31661 == "US" }.first?.releaseDates.first?.certification ?? ""
    }
    
    var getPosterPathURL: URL? {
        return URL(string: posterPath?.getPosterImageURL(imageType: .poster(width: .original)) ?? "")
    }
    
    var getStringFormattedGenres: String {
        return genres.map{ $0.name }.joined(separator: ", ")
    }
}
