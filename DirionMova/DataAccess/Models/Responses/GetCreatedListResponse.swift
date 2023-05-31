//
//  CreatedListResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/2/22.
//

struct GetCreatedListResponse: Decodable {
    let results: [GetCreatedListResult]
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalResults = "total_results"
    }
}

struct GetCreatedListResult: Codable {
    let id: Int
}
