//
//  PrivacyPolicyElementModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 10.01.2023.
//

import Foundation

struct PrivacyPolicyElementModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
}
