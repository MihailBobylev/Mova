//
//  LanguageViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 11.01.2023.
//

import Foundation

class LanguageViewModel: ObservableObject {
    @Published var suggested = [
        "English (US)",
        "Russian"
    ]
    
    @Published var languages = [String]()
    
    func fillLanguages() {
        Languages.languages.forEach { language in
            languages.append(language)
        }
    }
    
    func addInSuggested(language: String) {
        if !suggested.contains(language) {
            suggested.append(language)
        }
    }
}
