//
//  NameTextFieldView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.10.2022.
//

import SwiftUI

struct NameTextFieldView: View {
    @Binding var text: String
    @Binding var isTextFieldDataNotValid: Bool
    let titleKey: String
    let type: SelectedTextField
    @State private var isFirstResponder = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            MovaTextField(text: $text, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
                .padding([.leading, .trailing], 20.dhs)
        }
        .frame(height: 56.dvs, alignment: .center)
    }
}

struct NameTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NameTextFieldView(text: .constant(""), isTextFieldDataNotValid: .constant(true), titleKey: "Full Name", type: .fullName)
    }
}
