//
//  ServerConstants.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.10.2022.
//

import Foundation

enum ServerConstants {
    static let baseURL = Bundle.main.serverBaseURL
    static let apiKey = Bundle.main.apiKey
    static let imagesBaseURL = Bundle.main.serverWithImagesBaseURL
    static let descriptionBaseURL = Bundle.main.serverWithDescriptionBaseURL
    
    static var httpHeaders: [String: String] {
        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }
}
