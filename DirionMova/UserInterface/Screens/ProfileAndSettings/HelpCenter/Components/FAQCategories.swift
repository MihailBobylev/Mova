//
//  FAQCategories.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 29.12.2022.
//

import SwiftUI

struct FAQCategories: View {
    @State private var selectedCategory: [ProblemType] = [.all]
    @ObservedObject var faqViewModel: FAQViewModel
    let action: ([ProblemType]) -> Void
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12.dhs) {
                Spacer(minLength: 12.dhs)
                ForEach(faqViewModel.categoriesFAQ, id: \.self) { category in
                    CategoryType(faqViewModel: faqViewModel, category: category) {
                        selectAction(category)
                    }
                    .onChange(of: faqViewModel.searchTitle) { _ in
                        if selectedCategory != [.all] {
                            selectedCategory = [.all]
                        }
                    }
                }
                Spacer(minLength: 12.dhs)
            }
            .frame(height: 40.dvs)
        }
    }
}

struct FAQCategories_Previews: PreviewProvider {
    static var previews: some View {
        FAQCategories(faqViewModel: FAQViewModel()) { cetegory in
            
        }
    }
}

extension FAQCategories {
    private func selectAction(_ category: ProblemType) {
        defer { action(selectedCategory) }
        
        if category == .all {
            selectedCategory = [.all]
            return
        }
        if selectedCategory.contains(category) {
            selectedCategory = selectedCategory.filter { $0 != category }
        } else {
            selectedCategory = selectedCategory.filter { $0 != .all }
            selectedCategory.append(category)
        }
        if selectedCategory.isEmpty {
            selectedCategory = [.all]
        }
    }
}
