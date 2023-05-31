//
//  GenreElement.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

struct SelectedElement: View {
    let text: String
    let tapAction: () -> ()
    
    var body: some View {
        Text(text)
            .frame(height: 19.dvs)
            .fixedSize()
            .padding(EdgeInsets(top: 8.dvs, leading: 20.dhs, bottom: 8.dvs, trailing: 20.dhs))
            .font(Font.Urbanist.Bold.size(of: 16.dfs))
            .background(Color(UIColor.MOVA.primary500))
            .foregroundColor(.white)
            .clipShape(Capsule())
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color(UIColor.MOVA.primary500), lineWidth: 2)
            )
            .onTapGesture {
                tapAction()
            }
    }
}

struct SelectedElement_Previews: PreviewProvider {
    static var previews: some View {
        SelectedElement(text: "Horror") {}
    }
}
