//
//  CreateListResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/2/22.
//

struct CreateListResponse: Decodable {
    let statusCode: Int
    let statusMessage: String
    let success: Bool
    let listId: Int
    
    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
        case listId = "list_id"
    }
    
}

