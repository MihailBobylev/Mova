//
//  PhoneTextFieldView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.10.2022.
//

import SwiftUI

struct PhoneTextFieldView: View {
    @State private var isFirstResponder = false
    @Binding var countryCode: String
    @Binding var countryFlag: String
    @Binding var phoneNumber: String
    
    let type: SelectedTextField
    let isShowCountryCodes: Bool
    let tapAction: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .frame(height: 56.dvs, alignment: .center)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            
            HStack (spacing: 0) {
                Button {
                    tapAction()
                } label: {
                    HStack(spacing: 12.dhs) {
                        Text("\(countryFlag)")
                            .font(.Urbanist.SemiBold.size(of: 34.dfs))
                            .cornerRadius(10)
                            .foregroundColor(countryCode.isEmpty ? .secondary : Color(UIColor.MOVA.Greyscale900White))
                        Image("arrowLightDownBold")
                    }
                    .padding(.leading, 20.dhs)
                }
                Text("+\(countryCode) ")
                    .font(.Urbanist.SemiBold.size(of: 14.dfs))
                    .padding(.leading, 20.dhs)
                MovaTextField(text: $phoneNumber, type: type, isSecured: false, isFirstResponder: $isFirstResponder)
                    .padding(.trailing, 20.dhs)
            }
        }
        .frame(height: 56.dvs, alignment: .center)
    }
}

struct PhoneTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneTextFieldView(countryCode: .constant("61"), countryFlag: .constant("🇦🇺"), phoneNumber: .constant(""), type: .fullPhoneNumber, isShowCountryCodes: false) {}
    }
}
