//
//  CustomPasswordTextFieldView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.11.2022.
//

import SwiftUI

struct MovaPasswordTextFieldView: View {
    @Binding var text: String
    @State private var isSecured = true
    let type: SelectedTextField
    @State private var isFirstResponder = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color.TexFields.activeBackground : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color.TexFields.fieldText : Color(UIColor.clear)))
            HStack {
                Image(getLockImageName())
                    .frame(width: 20, height: 20)
                    .padding(.leading, 20)
                MovaTextField(text: $text, type: type, isSecured: isSecured, isFirstResponder: $isFirstResponder)
                    .padding(.trailing, 32)
                Image(getShowHideButtonImageName())
                    .frame(width: 11)
                    .padding(.trailing, 21)
                    .onTapGesture {
                        isSecured.toggle()
                    }
            }
        }
        .frame(height: 60.dvs)
    }
    
    private func getShowHideButtonImageName() -> String {
        var name = ""
        var image = ""
        isSecured ? (image = "hide") : (image = "show")
        
        if text.count < 1 && !isFirstResponder {
            name = "\(image)BoldGrey"
        } else if text.count >= 1 && !isFirstResponder {
            name = "\(image)BoldBlack"
        } else if isFirstResponder {
            name = "\(image)BoldRed"
        }
        return name
    }
    
    private func getLockImageName() -> String {
        var name = ""
        if text.count < 1 && !isFirstResponder {
            name = "lockBoldGrey"
        } else if text.count >= 1 && !isFirstResponder {
            name = "lockBoldBlack"
        } else if isFirstResponder {
            name = "lockBoldRed"
        }
        return name
    }
}

struct CustomPasswordTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        MovaPasswordTextFieldView(text: .constant(""), type: .password)
    }
}
