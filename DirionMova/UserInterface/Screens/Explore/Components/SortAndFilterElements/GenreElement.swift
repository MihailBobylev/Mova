//
//  GenreElement.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

struct GenreElement: View {
    @ObservedObject var exploreViewModel: ExploreViewModel
    @State private var isSelected = false
    let genre: Genre
    
    let tapAction: (_ isSelected: Bool) -> ()
    
    var body: some View {
        Text(genre.name)
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
                    isSelected.toggle()
                    tapAction(isSelected)
                }
            }
            .onChange(of: exploreViewModel.isReset) { newValue in
                if newValue {
                    isSelected = false
                }
            }
            .onChange(of: exploreViewModel.deletedElement) { newValue in
                if newValue == genre.name {
                    exploreViewModel.withGenres = exploreViewModel.withGenres.filter { $0 != String(genre.id) }
                    exploreViewModel.selectedFilters = exploreViewModel.selectedFilters.filter { $0 != genre.name }
                    exploreViewModel.deletedElement = ""
                    exploreViewModel.getDiscoverMovies()
                    isSelected = false
                }
            }
    }
    
    private func backColor() -> Color {
        !exploreViewModel.isReset && exploreViewModel.deletedElement != genre.name && isSelected ? Color(UIColor.MOVA.primary500) : .clear
    }
    
    private func fontColor() -> Color {
        !exploreViewModel.isReset && exploreViewModel.deletedElement != genre.name && isSelected ? .white : Color(UIColor.MOVA.primary500)
    }
}

struct GenreElement_Previews: PreviewProvider {
    static var previews: some View {
        GenreElement(exploreViewModel: ExploreViewModel(), genre: Genre(id: 1, name: "Horror")) { isSelected in }
    }
}
