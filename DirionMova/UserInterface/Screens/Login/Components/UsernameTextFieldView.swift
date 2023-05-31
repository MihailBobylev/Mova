//
//  UsernameTextFieldView.swift
//  DirionMova
//
//  Created by Юрий Альт on 06.10.2022.
//

import SwiftUI

struct UsernameTextFieldView: View {
    @Binding var text: String
    let type: SelectedTextField
    @State private var isFirstResponder = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            HStack {
                Image(getImageName())
                    .padding(.leading, 20)
                MovaTextField(text: $text, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
            }
        }
        .frame(height: 56.dvs, alignment: .center)
    }
    
    private func getImageName() -> String {
        var name = ""
        if text.count < 1 && !isFirstResponder {
            name = "profileBoldGrey"
        } else if text.count >= 1 && !isFirstResponder {
            name = "profileBoldBlack"
        } else if isFirstResponder {
            name = "profileBoldRed"
        }
        return name
    }
}

struct EmailTextField_Previews: PreviewProvider {
    static var previews: some View {
        UsernameTextFieldView(text: .constant(""), type: .email)
    }
}
