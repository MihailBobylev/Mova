//
//  FAQViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//

import SwiftUI

struct FAQView: View {
    @ObservedObject var faqViewModel: FAQViewModel
    @Binding var searchBarOffsetY: CGFloat
    
    var body: some View {
        VStack(spacing: 24.dvs) {
            FAQCategories(faqViewModel: faqViewModel) { category in
                faqViewModel.filteredCategories = faqViewModel.filterByCategory(categories: category)
            }
            
            SearchBarFAQ(isFirstResponder: $faqViewModel.isFirstResponder, text: $faqViewModel.searchTitle) {
                faqViewModel.makeSearchWithDelay()
            } commitAction: {
                faqViewModel.filteredFAQ = faqViewModel.getFilteredFAQ()
            }
            .padding(.horizontal, 24.dhs)
            .background(
                GeometryReader { geo -> Color in
                    DispatchQueue.main.async {
                        searchBarOffsetY = geo.frame(in: .global).maxY
                    }
                    return Color.clear
                }
            )
            
            LazyVStack(spacing: 24.dvs) {
                ForEach(faqViewModel.filteredCategories) { problem in
                    FAQProblem(faqViewModel: faqViewModel, faqProblemModel: FAQProblemModel(title: problem.title, description: problem.description, type: problem.type))
                        .id(problem.id)
                }
            }
            .padding(.horizontal, 24.dhs)
        }
        .onAppear {
            faqViewModel.filteredCategories = faqViewModel.filterByCategory(categories: [.all])
        }
    }
}

struct FAQView_Previews: PreviewProvider {
    static var previews: some View {
        FAQView(faqViewModel: FAQViewModel(), searchBarOffsetY: .constant(48))
    }
}
