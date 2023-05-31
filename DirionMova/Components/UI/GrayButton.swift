//
//  GrayButton.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 19.10.2022.
//

import SwiftUI

struct GrayButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .font(Font.Urbanist.Bold.size(of: 16.dfs))
            .background(Color.GrayButton.background)
            .foregroundColor(.GrayButton.text)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
