//
//  AuthResponse.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.10.2022.
//

struct AuthTokenResponse: Decodable {
    let success: Bool
    let expiresAt: String
    let requestToken: String

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
