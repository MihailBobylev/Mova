//
//  HelpCenterDetailsButton.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import SwiftUI

struct HelpCenterDetailsButton: View {
    private let buttonTitles = ["FAQ", "Contact us"]
    @Binding var currentIndex: Int
    let tapAction: (_ index: Int) -> ()
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<buttonTitles.count, id: \.self) { index in
                Button(action: {
                    currentIndex = index
                    tapAction(index)
                }, label: {
                    VStack(spacing: 12.dvs) {
                        Text(buttonTitles[index])
                            .foregroundColor(index == currentIndex ? Color(UIColor.MOVA.primary500) : Color(UIColor.MOVA.Greyscale500Greyscale700))
                            .font(Font.Urbanist.SemiBold.size(of: 18.dfs))
                            .lineLimit(1)
                        Capsule()
                            .frame(height: index == currentIndex ? 4 : 2)
                            .foregroundColor(index == currentIndex ? Color(UIColor.MOVA.primary500) : Color(UIColor.MOVA.Greyscale200Dark3))
                            .padding(.bottom, index == currentIndex  ? 0 : 2)
                    }
                })
                .tag(index)
            }
        }
    }
}

struct HelpCenterDetailsButton_Previews: PreviewProvider {
    static var previews: some View {
        HelpCenterDetailsButton(currentIndex: .constant(0)) { tmp in
            
        }
    }
}
