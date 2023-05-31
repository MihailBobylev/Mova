//
//  ValidateWithLoginRequest.swift
//  DirionMova
//
//  Created by Юрий Альт on 11.10.2022.
//

struct ValidateWithLoginRequest: Codable {
    let userName: String
    let password: String
    let requestToken: String
    
    enum CodingKeys: String, CodingKey {
        case userName = "username"
        case password
        case requestToken = "request_token"
    }
}
