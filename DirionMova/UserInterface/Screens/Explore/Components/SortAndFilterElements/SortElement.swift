//
//  GenreElement.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

struct SortElement: View {
    @ObservedObject var exploreViewModel: ExploreViewModel
    let text: String
    
    let tapAction: () -> ()
    
    var body: some View {
        Text(text)
            .frame(height: 19.dvs)
            .fixedSize()
            .padding(EdgeInsets(top: 8.dvs, leading: 20.dhs, bottom: 8.dvs, trailing: 20.dhs))
            .font(Font.Urbanist.Bold.size(of: 16.dfs))
            .background(backColor())
            .foregroundColor(fontColor())
            .clipShape(Capsule())
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color(UIColor.MOVA.primary500), lineWidth: 2)
            )
            .onTapGesture {
                withAnimation (.spring()) {
                    exploreViewModel.isReset = false
                    tapAction()
                }
            }
            .onChange(of: exploreViewModel.deletedElement) { newValue in
                if newValue == text {
                    exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter { $0 != text}
                    exploreViewModel.sortBy = .popularity
                    exploreViewModel.deletedElement = ""
                    exploreViewModel.getDiscoverMovies()
                }
            }
    }
    
    private func backColor() -> Color {
        !exploreViewModel.isReset && exploreViewModel.sortBy.rawValue == text ? Color(UIColor.MOVA.primary500) : .clear
    }
    
    private func fontColor() -> Color {
        !exploreViewModel.isReset && exploreViewModel.sortBy.rawValue == text ? .white : Color(UIColor.MOVA.primary500)
    }
}

struct SortElement_Previews: PreviewProvider {
    static var previews: some View {
        SortElement(exploreViewModel: ExploreViewModel(), text: "Horror") {}
    }
}
