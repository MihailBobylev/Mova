//
//  InterestElement.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.10.2022.
//

import SwiftUI

struct InterestElement: View {
    @State private var isSelected = false
    @Binding var selectedInterests: [String]
    let text: String
    
    var body: some View {
        Text(text)
            .padding(.horizontal, 24.dhs)
            .padding(.vertical, 10.dvs)
            .font(Font.Urbanist.Bold.size(of: 18))
            .background(isSelected ? Color(UIColor.MOVA.primary500) : .clear)
            .foregroundColor(isSelected ? .white : Color(UIColor.MOVA.primary500))
            .clipShape(Capsule())
            .overlay(
                RoundedRectangle(cornerRadius: 100)
                    .stroke(Color(UIColor.MOVA.primary500), lineWidth: 2)
            )
            .onTapGesture {
                isSelected.toggle()
                if isSelected {
                    selectedInterests.append(text)
                }
            }
    }
}

struct InterestElement_Previews: PreviewProvider {
    static var previews: some View {
        InterestElement(selectedInterests: .constant(["s"]), text: "Horror")
    }
}
