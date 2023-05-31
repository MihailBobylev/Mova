//
//  CheckMovieStatusResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/16/22.
//

struct CheckMovieStatusResponse: Decodable {
    let itemPresent: Bool
    
    enum CodingKeys: String, CodingKey {
        case itemPresent = "item_present"
    }
}
