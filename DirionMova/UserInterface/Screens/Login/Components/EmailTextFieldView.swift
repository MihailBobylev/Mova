//
//  EmailTextFieldView.swift
//  DirionMova
//
//  Created by Юрий Альт on 30.11.2022.
//

import SwiftUI

enum EmailTextFieldIconPlacement: String {
    case left = "messageBold"
    case right = "emailCurved"
}

struct EmailTextFieldView: View {
    @Binding var text: String
    let iconPlacement: EmailTextFieldIconPlacement
    let type: SelectedTextField
    @State private var isFirstResponder = false
    
    init(text: Binding<String>, type: SelectedTextField, iconPlacement: EmailTextFieldIconPlacement = .left) {
        self._text = text
        self.type = type
        self.iconPlacement = iconPlacement
    }
    
    var body: some View {
        switch iconPlacement {
        case .right:
            RightEmailTextFiled(
                text: $text,
                isFirstResponder: $isFirstResponder,
                getIconString: getImageName,
                type: type)
        case .left:
            LeftEmailTextFiled(
                text: $text,
                isFirstResponder: $isFirstResponder,
                getIconString: getImageName,
                type: type)
        }
    }
    
    private func getImageName() -> String {
        var name = ""
        if text.count < 1 && !isFirstResponder {
            name = iconPlacement.rawValue
        } else if text.count >= 1 && !isFirstResponder {
            name = "\(iconPlacement.rawValue)Black"
        } else if isFirstResponder {
            name = "\(iconPlacement.rawValue)Red"
        }
        return name
    }
}

fileprivate struct LeftEmailTextFiled: View {
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var getIconString: () -> String
    let type: SelectedTextField
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            HStack {
                Image(getIconString())
                    .padding(.leading, 20.dhs)
                MovaTextField(text: $text, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
            }
        }
        .frame(height: 56.dvs, alignment: .center)
    }
}

fileprivate struct RightEmailTextFiled: View {
    @Binding var text: String
    @Binding var isFirstResponder: Bool
    var getIconString: () -> String
    let type: SelectedTextField
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            HStack {
                MovaTextField(text: $text, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
                    .padding([.leading, .trailing], 20.dhs)
                Image(getIconString())
            }
            .padding(.trailing, 24.dhs)
        }
        .frame(height: 56.dvs, alignment: .center)
    }
}
