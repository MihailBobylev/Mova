//
//  ContactType.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//

import Foundation

enum ContactType: CaseIterable {
    case customerService
    case whatsApp
    case website
    case facebook
    case twitter
    case instagram
    
    var title: String {
        switch self {
        case .customerService:
            return "Customer Service"
        case .whatsApp:
            return "WhatsApp"
        case .website:
            return "Website"
        case .facebook:
            return "Facebook"
        case .twitter:
            return "Twitter"
        case .instagram:
            return "Instagram"
        }
    }
    
    var image: String {
        switch self {
        case .customerService:
            return "customerService"
        case .whatsApp:
            return "whatsApp"
        case .website:
            return "website"
        case .facebook:
            return "facebook"
        case .twitter:
            return "twitter"
        case .instagram:
            return "instagram"
        }
    }
}
