//
//  ValidateWithLoginResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 23.11.2022.
//

struct ValidateWithLoginResponse: Decodable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
