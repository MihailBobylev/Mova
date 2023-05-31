//
//  CustomProgressViewStyle.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 23.01.2023.
//

import SwiftUI

struct CustomProgressViewStyle: ProgressViewStyle {
    let width: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 100)
                .frame(width: width, height: 8.dvs)
                .foregroundColor(.ProgressPopUp.foregroundColor)
            
            RoundedRectangle(cornerRadius: 100)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * width, height: 8.dvs)
                .foregroundColor(.ProgressPopUp.accentColor)
        }
    }
}
