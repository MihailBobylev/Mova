//
//  MovaToggle.swift
//  DirionMova
//
//  Created by Юрий Альт on 26.11.2022.
//

import SwiftUI

struct MovaToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(isOn ? .MovaToggle.isOnBackground : .MovaToggle.isOffBackground)
            HStack {
                Circle()
                    .foregroundColor(.MovaToggle.handleBackground)
                    .frame(height: 20.dvs)
                    .offset(x: isOn ? 22 : 2, y: 0)
                Spacer()
            }
        }
        .animation(.easeInOut)
        .gesture(
            TapGesture()
                .onEnded {
                    isOn.toggle()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
        )
        .gesture(
            DragGesture()
                .onEnded { _ in
                    isOn.toggle()
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                }
        )
        .frame(width: 44.dhs, height: 24.dvs)
    }
}


struct MovaToggle_Previews: PreviewProvider {
    static var previews: some View {
        MovaToggle(isOn: .constant(true))
    }
}
