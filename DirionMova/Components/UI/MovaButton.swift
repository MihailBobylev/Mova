//
//  MovaButton.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/5/22.
//

import SwiftUI

struct MovaButton: ButtonStyle {
    var isButtonActive = true
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .frame(minHeight: 0, maxHeight: .infinity)
            .font(Font.Urbanist.Bold.size(of: 16.dfs))
            .background(isButtonActive ? Color.MovaButton.backgroundActive : Color.MovaButton.backgroundInactive)
            .foregroundColor(.white)
            .clipShape(Capsule())
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
