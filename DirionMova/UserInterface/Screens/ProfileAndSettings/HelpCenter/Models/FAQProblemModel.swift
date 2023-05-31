//
//  FAQProblemModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import Foundation

struct FAQProblemModel: Identifiable, Equatable {
    
    let id = UUID()
    let title: String
    let description: String
    let type: ProblemType
    
    init(title: String, description: String, type: ProblemType) {
        self.title = title
        self.description = description
        self.type = type
    }
}
