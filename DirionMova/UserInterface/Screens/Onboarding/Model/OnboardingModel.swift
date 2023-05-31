//
//  OnboardingModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/6/22.
//

import Foundation

enum OnboardingModel: CaseIterable {
    case first, second, third
    
    var title: String {
        switch self {
        case .first: return "Welcome to Mova"
        case .second: return "Convenient search"
        case .third: return "Simple and easy"
        }
    }
    
    var description: String {
        switch self {
        case .first: return "The best movie streaming app of the century to make your days great!"
        case .second: return "Find movies quickly with tags, save your favorite movies to “My list”"
        case .third: return "Share your favorite movies with your friends"
        }
    }
    
    var backgroundImage: String {
        switch self {
        case .first: return "firstMovie"
        case .second: return "secondMovie"
        case .third: return "thirdMovie"
        }
    }
}
