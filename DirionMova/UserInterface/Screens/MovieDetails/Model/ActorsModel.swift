//
//  ActorsModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/5/22.
//

import Foundation

enum ActorType: CaseIterable {
    case director
    case writer
    case producer
    
    var title: [String] {
        switch self {
        case .director:
            return ["Director"]
        case .producer:
            return ["Producer"]
        case .writer:
            return ["Writer", "Novel", "Story"]
        }
    }
}

struct ActorsModel {
    let name: String
    let job: String
    let picturePath: String
}
