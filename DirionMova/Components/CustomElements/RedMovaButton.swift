//
//  RedMovaButton.swift
//  DirionMova
//
//  Created by Юрий Альт on 01.12.2022.
//

import SwiftUI

struct RedMovaButton: View {
    @State private var isButtonTapped = false
    let action: () -> ()
    let isActive: Bool
    let text: String
    
    var body: some View {
        Button(action: isActive ? action : {}) {
            ZStack {
                Capsule()
                    .fill(isActive ? Color.MovaButton.backgroundActive : Color.MovaButton.backgroundInactive)
                Text(text)
                    .padding(.vertical, 18.dvs)
                    .font(Font.Urbanist.Bold.size(of: 16.dfs))
                    .foregroundColor(.MovaButton.text)
            }
        }
        .buttonStyle(ScaleButtonStyle())
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
