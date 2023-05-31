//
//  RemoveAndAddMovieResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/9/22.
//

struct RemoveAndAddMovieResponse: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
