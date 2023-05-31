//
//  CustomButton.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.10.2022.
//

import SwiftUI

struct CustomBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Image("arrowLeftLight")
            .frame(width: 28, height: 28)
            .onTapGesture {
                presentationMode.wrappedValue.dismiss()
            }
    }
}

struct CustomBackButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomBackButton()
    }
}
