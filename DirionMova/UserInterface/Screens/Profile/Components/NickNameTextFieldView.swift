//
//  NameTextFieldView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.10.2022.
//

import SwiftUI

struct NickNameTextFieldView: View {
    @Binding var text: String
    @Binding var isTextFieldDataNotValid: Bool
    let type: SelectedTextField
    @State private var isFirstResponder = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color.TexFields.activeBackground : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color.TexFields.fieldText : Color(UIColor.clear)))
            HStack {
                Image(getUserImage())
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.leading, 21)
                MovaTextField(text: $text, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
                    .padding(.trailing, 20)
            }
        }
        .frame(height: 60, alignment: .center)
    }
    
    private func getUserImage() -> String {
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

struct NickNameTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        NickNameTextFieldView(text: .constant(""), isTextFieldDataNotValid: .constant(true), type: .fullName)
    }
}
