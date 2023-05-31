//
//  EnterGuestResponse.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/24/22.
//

struct EnterGuestResponse: Decodable {
    let success: Bool
    let guestSessionId: String
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case success
        case guestSessionId = "guest_session_id"
        case expiresAt = "expires_at"
    }
}
