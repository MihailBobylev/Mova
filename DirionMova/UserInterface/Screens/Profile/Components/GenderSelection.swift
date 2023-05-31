//
//  GenderSelection.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 13.12.2022.
//

import SwiftUI

enum GenderType {
    case male
    case female
    case nonBinary
    case notSpecify
    
    func getGenderName() -> String {
        switch self {
        case .male:
            return "Male"
        case .female:
            return "Female"
        case .nonBinary:
            return "Non-binary"
        case .notSpecify:
            return "Not specify"
        }
    }
}

struct GenderSelection: View {
    @State var openMenu = false
    @State private var selectedOption: GenderType = .notSpecify
    
    var placeholder: String
    
    var body: some View {
        Menu {
            Button {
                selectedOption = .notSpecify
            } label: {
                Text("Not specify")
            }
            Button {
                selectedOption = .nonBinary
            } label: {
                Text("Non-binary")
            }
            Button {
                selectedOption = .female
            } label: {
                Text("Female")
            }
            Button {
                selectedOption = .male
            } label: {
                Text("Male")
            }
        } label: {
            GeometryReader { _ in
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.TexFields.background)
                        .frame(height: 56.dvs, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(lineWidth: 1)
                                .foregroundColor(Color(UIColor.clear))
                        )
                    HStack {
                        Text(selectedOption == .notSpecify ? placeholder : selectedOption.getGenderName())
                            .font(.Urbanist.SemiBold.size(of: 14.dfs))
                            .foregroundColor(selectedOption == .notSpecify ? Color(UIColor.MOVA.greyscale500) : Color(UIColor.MOVA.Greyscale900White))
                        
                        Spacer()
                        
                        Image(selectedOption == .notSpecify ? "arrowDownGray" : "arrowDownBlack")
                    }
                    .padding(.leading, 20.dhs)
                    .padding(.trailing, 24.dhs)
                }
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

struct GenderSelection_Previews: PreviewProvider {
    static var previews: some View {
        GenderSelection(placeholder: "Gender")
    }
}
