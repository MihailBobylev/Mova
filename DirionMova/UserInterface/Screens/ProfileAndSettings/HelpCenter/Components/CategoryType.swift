//
//  CategoryType.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import SwiftUI

struct CategoryType: View {
    @State private var isSelected = false
    @ObservedObject var faqViewModel: FAQViewModel
    let category: ProblemType
    let tapAction: () -> ()
    
    var body: some View {
        Text(category.rawValue)
            .frame(height: 22.dvs)
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
                    isSelected.toggle()
                    tapAction()
                }
            }
            .onChange(of: faqViewModel.searchTitle) { _ in
                isSelected = false
                
            }
    }
    
    private func backColor() -> Color {
         isSelected ? Color(UIColor.MOVA.primary500) : .clear
    }
    
    private func fontColor() -> Color {
        isSelected ? .white : Color(UIColor.MOVA.primary500)
    }
}

struct CategoryType_Previews: PreviewProvider {
    static var previews: some View {
        CategoryType(faqViewModel: FAQViewModel(), category: .general){}
    }
}
