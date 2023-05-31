//
//  RateMovieResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 08.11.2022.
//

struct RateMovieResponse: Decodable {
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
