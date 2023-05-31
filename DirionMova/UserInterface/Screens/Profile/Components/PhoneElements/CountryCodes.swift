//
//  PhoneTextFieldView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.10.2022.
//

import SwiftUI

enum CountryCodeViewType {
    case withCode
    case withoutCode
}

struct CountryCodeView: View {
    @Binding var countryCode: String
    @Binding var countryFlag: String
    @Binding var isShowCountryCodes: Bool
    @Binding var countryName: String
    let type: CountryCodeViewType
    let countryDictionary = CountryDictionary()
    
    init(countryCode: Binding<String> = .constant(""),
         countryFlag: Binding<String> = .constant(""),
         isShowCountryCodes: Binding<Bool>,
         countryName: Binding<String> = .constant(""),
         type: CountryCodeViewType = .withCode) {
        self._countryCode = countryCode
        self._countryFlag = countryFlag
        self._isShowCountryCodes = isShowCountryCodes
        self._countryName = countryName
        self.type = type
    }
    
    var body: some View {
        GeometryReader { geo in
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation(.spring()) {
                        isShowCountryCodes.toggle()
                    }
                }
            List(countryDictionary.countries.sorted(by: <), id: \.key) { key, value in
                HStack {
                    Text("\(countryDictionary.flag(country: key))")
                    Text("\(countryDictionary.countryName(countryCode: key) ?? key)")
                    Spacer()
                        Text("+\(value)").foregroundColor(.secondary)
                        .opacity(type == .withCode ? 1 : 0)
                }
                .font(.system(size: 20.dfs))
                .onTapGesture {
                    countryName = countryDictionary.countryName(countryCode: key) ?? key
                    countryCode = value
                    countryFlag = countryDictionary.flag(country: key)
                    withAnimation(.spring()) {
                        isShowCountryCodes = false
                    }
                }
            }
            .listStyle(.inset)
            .frame(width: geo.size.width * 0.8, height: 600.dvs)
            .frame(width: geo.size.width, height: geo.size.height)
            .cornerRadius(30, corners: .allCorners)
        }
    }
}

struct CountryCodeView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCodeView(isShowCountryCodes: .constant(true))
    }
}
