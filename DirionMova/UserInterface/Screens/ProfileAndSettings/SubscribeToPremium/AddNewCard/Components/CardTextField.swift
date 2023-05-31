//
//  CardTextField.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 16.12.2022.
//

import SwiftUI

struct CardTextField: View {
    @State private var isFirstResponder = false
    @Binding var text: String
    
    let type: SelectedTextField
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            HStack {
                MovaTextField(text: $text, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
                    .padding(.leading, 20.dhs)
            }
        }
        .frame(height: 56.dvs, alignment: .center)
    }
}

struct CardTextField_Previews: PreviewProvider {
    static var previews: some View {
        CardTextField(text: .constant("Card"), type: .cardName)
    }
}
