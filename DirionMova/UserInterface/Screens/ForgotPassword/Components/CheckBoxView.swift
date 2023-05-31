//
//  CheckBoxView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 07.12.2022.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    
    var body: some View {
        Image(checked ? "checkboxChecked" : "checkboxUnchecked")
            .resizable()
            .scaledToFit()
            .frame(width: 24.dhs, height: 24.dvs)
            .onTapGesture {
                self.checked.toggle()
            }
    }
}

struct CheckBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxView(checked: .constant(true))
    }
}
