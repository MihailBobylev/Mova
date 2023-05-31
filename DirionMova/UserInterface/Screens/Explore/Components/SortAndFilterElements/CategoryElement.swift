//
//  GenreElement.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

struct CategoryElement: View {
    @ObservedObject var exploreViewModel: ExploreViewModel
    let text: String
    
    let tapAction: () -> ()
    
    var body: some View {
        Text(text)
            .frame(height: 19.dvs)
            .fixedSize()
            .padding(EdgeInsets(top: 8.dvs, leading: 20.dhs, bottom: 8.dvs, trailing: 20.dhs))
            .font(Font.Urbanist.Bold.size(of: 16.dfs))
            .background(!exploreViewModel.isReset && (exploreViewModel.category.rawValue == text) ? Color(UIColor.MOVA.primary500) : .clear)
            .foregroundColor(!exploreViewModel.isReset && (exploreViewModel.category.rawValue == text) ? .white : Color(UIColor.MOVA.primary500))
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
    }
}

struct CategoryElement_Previews: PreviewProvider {
    static var previews: some View {
        CategoryElement(exploreViewModel: ExploreViewModel(), text: "Horror") {}
    }
}
