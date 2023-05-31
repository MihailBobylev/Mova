//
//  LanguageMenuElement.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 11.01.2023.
//

import SwiftUI

struct LanguageMenuElement: View {
    let language: String
    @Binding var selected: String
    
    var body: some View {
        Button(action: { selected = language }) {
            HStack {
                Text(verbatim: language)
                    .font(.Urbanist.SemiBold.size(of: 18.dfs))
                    .foregroundColor(.ProfileAndSettingsView.menuElementText)
                Spacer()
                Image(selected == language ? "circleFill" : "circleEmpty")
                .frame(width: 20, height: 20)
                .padding(.trailing, 24.dhs)
            }
        }
    }
}

struct LanguageMenuElement_Previews: PreviewProvider {
    static var previews: some View {
        LanguageMenuElement(language: "Russian", selected: .constant("Russian"))
    }
}
