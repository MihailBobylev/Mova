//
//  MarqueeText.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/2/22.
//

import SwiftUI

struct MarqueeText: View {
    let text: String
    private let font = UIFont(name: "Urbanist-Bold", size: 24.dfs)!
    private let animationSpeed = 0.2
    private let delayTime = 0.5
    @State private var storedSize: CGSize = .zero
    @State private var offset: CGFloat = 0
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal, showsIndicators: false) {
                Text(text)
                    .lineLimit(1)
                    .font(Font(font))
                    .offset(x: offset)
                    .foregroundColor(.MovieDetails.titleText)
            }.disabled(true)
                .onAppear {
                    storedSize = textSize()
                    if geo.size.width <= storedSize.width {
                        let timing: Double = (animationSpeed * (storedSize.width * 0.1))
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                            withAnimation(.linear(duration: timing)) {
                                offset = (geo.size.width - storedSize.width)
                            }
                        }
                    }
                }
                .onReceive(Timer.publish(every: ((animationSpeed * (storedSize.width * 0.1)) + delayTime),
                                         on: .main, in: .default).autoconnect()) { _ in
                    if geo.size.width <= storedSize.width {
                        offset = 0
                        withAnimation(.linear(duration: (animationSpeed * (storedSize.width * 0.1)))) {
                            offset = (geo.size.width - storedSize.width)
                        }
                    }
                }
        }
    }
    
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        return size
    }
}
