//
//  CountryDropDown.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/9/22.
//

import SwiftUI

struct CountryDropDown: View {
    @Binding var selectedCountry: String
    @Binding var shouldShowDropdown: Bool
    var placeholder: String
    let tapAction: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.TexFields.background)
                .frame(height: 56.dvs, alignment: .center)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 1)
                        .foregroundColor(Color(UIColor.clear))
                )
            
            Button(action: tapAction) {
                HStack {
                    Text(selectedCountry.isEmpty ? placeholder : selectedCountry)
                        .font(.Urbanist.SemiBold.size(of: 14.dfs))
                        .foregroundColor(selectedCountry.isEmpty ? Color(UIColor.MOVA.greyscale500) : Color(UIColor.MOVA.Greyscale900White))
                    Spacer()
                    
                    Image(selectedCountry.isEmpty ? "arrowDownGray" : "arrowDownBlack")
                }
                .padding(.leading, 20.dhs)
                .padding(.trailing, 24.dhs)
            }
        }
    }
}

struct CountryDropDown_Previews: PreviewProvider {
    static var previews: some View {
        CountryDropDown(selectedCountry: .constant(""), shouldShowDropdown: .constant(true), placeholder: "", tapAction: { })
    }
}
