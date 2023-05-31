//
//  AddCardStyle.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 15.12.2022.
//

import SwiftUI

struct AddCardStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .font(Font.Urbanist.Bold.size(of: 16.dfs))
            .background(Color.Payment.backgroundButton)
            .foregroundColor(Color.Payment.foregroundColorButton)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
