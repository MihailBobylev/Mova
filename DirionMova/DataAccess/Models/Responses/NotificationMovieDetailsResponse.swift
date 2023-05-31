//
//  NotificationMovieDetailsResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 27.12.2022.
//

import SwiftUI

struct NotificationMovieDetailsResponse: Decodable {
    let uuid = UUID()
    
    let id: Int
    let originalTitle: String
    let posterPath: String?
    let releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
}
