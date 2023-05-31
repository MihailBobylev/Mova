//
//  LoadingIndicatorView.swift
//  DirionMova
//
//  Created by Юрий Альт on 03.10.2022.
//

import SwiftUI

struct LoadingIndicatorView: View {
    @State private var isAnimationOn = false
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: size / 3.33, height: size / 3.33)
                .position(x: size / 2.5, y: size / 6.67)
            Circle()
                .frame(width: size / 4, height: size / 4)
                .position(x: size / 8, y: size / 2.35)
            Circle()
                .frame(width: size / 4, height: size / 4)
                .position(x: size / 4.29, y: size / 1.29)
            Circle()
                .frame(width: size / 5, height: size / 5)
                .position(x: size / 1.81, y: size / 1.11)
            Circle()
                .frame(width: size / 5, height: size / 5)
                .position(x: size / 1.22, y: size / 1.3)
            Circle()
                .frame(width: size / 6.67, height: size / 6.67)
                .position(x: size / 1.1, y: size / 1.85)
            Circle()
                .frame(width: size / 10, height: size / 10)
                .position(x: size / 1.18, y: size / 3.16)
            Circle()
                .frame(width: size / 20, height: size / 20)
                .position(x: size / 1.38, y: size / 5.7)
        }
        .foregroundColor(Color.LoadingIndicator.background)
        .rotationEffect(Angle(degrees: isAnimationOn ? 360 : 0))
        .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: isAnimationOn)
        .onAppear() {
            isAnimationOn.toggle()
        }
    }
}

struct LoadingIndicatorView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingIndicatorView(size: 60)
    }
}
