//
//  MyListCategories.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/8/22.
//

import SwiftUI

struct MyListCategories: View {
    var categories = Genres.allCases
    @State private var selectedCategory: [Genres] = [.allCategories]
    var isOpenDetails: Bool
    var action: ([Genres]) -> Void
    
    var body: some View {
        ScrollViewReader { reader in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Spacer(minLength: 24.dhs)
                        .id("Start")
                    ForEach(categories, id:  \.self) { category in
                        Button(action: {
                            selectAction(category)
                        }) {
                            Text(category.genreName)
                                .font(.Urbanist.SemiBold.size(of: 16.dfs))
                                .padding(.horizontal, 20.dhs)
                                .padding(.vertical, 8.dvs)
                                .background(selectedCategory.contains(category) ? Color.MovaButton.backgroundActive : .clear)
                                .foregroundColor(selectedCategory.contains(category) ? .white : Color.MovaButton.backgroundActive)
                                .clipShape(Capsule())
                                .overlay(
                                    Capsule()
                                        .stroke(Color.MovaButton.backgroundActive, lineWidth: 2))
                        }
                    }
                    Spacer(minLength: 24.dhs)
                }
                .frame(height: 40.dvs)
            }
            .onDisappear {
                if !isOpenDetails {
                    reader.scrollTo("Start")
                    selectedCategory = [.allCategories]
                }
            }
        }
    }
}

extension MyListCategories {
    
    private func selectAction(_ genre: Genres) {
        defer { action(selectedCategory) }
        
        if genre == .allCategories {
            selectedCategory = [.allCategories]
            return
        }
        if selectedCategory.contains(genre) {
            selectedCategory = selectedCategory.filter { $0 != genre }
        } else {
            selectedCategory = selectedCategory.filter { $0 != .allCategories }
            selectedCategory.append(genre)
        }
        if selectedCategory.isEmpty {
            selectedCategory = [.allCategories]
        }
    }
}
