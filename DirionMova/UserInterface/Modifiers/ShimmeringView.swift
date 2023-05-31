//
//  ShimmeringView.swift
//  DirionMova
//
//  Created by Artem Vaniukov on 02.12.2022.
//

import SwiftUI

struct ShimmeringView<Content: View>: View {
    private let content: () -> Content
    private let configuration: ShimmerConfiguration
    private let isActive: Bool
    @State private var startPoint: UnitPoint
    @State private var endPoint: UnitPoint
    @State private var isAnimating = false
    private lazy var animation = Animation.linear(duration: configuration.duration).repeatForever(autoreverses: false)
    
    init(configuration: ShimmerConfiguration, isActive: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.configuration = configuration
        self.content = content
        self.isActive = isActive
        _startPoint = .init(wrappedValue: configuration.initialLocation.start)
        _endPoint = .init(wrappedValue: configuration.initialLocation.end)
    }
    
    var body: some View {
        ZStack {
            content()
            if isActive {
                LinearGradient(gradient: configuration.gradient, startPoint: startPoint, endPoint: endPoint)
                    .opacity(configuration.opacity)
                    .cornerRadius(10)
                    .blendMode(.screen)
                    .onAppear {
                        DispatchQueue.main.async {
                            withAnimation(.linear(duration: configuration.duration).repeatForever(autoreverses: false)) {
                                startPoint = configuration.finalLocation.start
                                endPoint = configuration.finalLocation.end
                            }
                        }
                    }
            }
        }
    }
}

struct ShimmerConfiguration {
    let gradient: Gradient
    let initialLocation: (start: UnitPoint, end: UnitPoint)
    let finalLocation: (start: UnitPoint, end: UnitPoint)
    let duration: TimeInterval
    let opacity: Double
    
    static let standard = ShimmerConfiguration(
        gradient: Gradient(stops: [
            .init(color: .black, location: 0),
            .init(color: .white, location: 0.3),
            .init(color: .white, location: 0.5),
            .init(color: .black, location: 0.9)
        ]),
        initialLocation: (start: UnitPoint(x: -2, y: 0.5), end: .leading),
        finalLocation: (start: .trailing, end: UnitPoint(x: 2, y: 0.5)),
        duration: 1.5,
        opacity: 0.6
    )
}

struct ShimmerModifier: ViewModifier {
    let configuration: ShimmerConfiguration
    let isActive: Bool
    func body(content: Content) -> some View {
        ShimmeringView(configuration: configuration, isActive: isActive) { content }
    }
}

extension View {
    func shimmer(configuration: ShimmerConfiguration = .standard, isActive: Bool = true) -> some View {
        modifier(ShimmerModifier(configuration: configuration, isActive: isActive))
    }
}
