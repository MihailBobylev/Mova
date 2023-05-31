//
//  HelpCenterViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import Foundation

class HelpCenterViewModel: ObservableObject {
    @Published var componentsIndex = 0
    @Published var isSorryTopupDisplayed = false
}
