//
//  ScrollMovementOverlay.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/1/22.
//

import SwiftUI

struct ScrollMovementOverlay: View {
    enum Move: String {
        case top = "SCROLL_TO_TOP"
        case bottom = "SCROLL_TO_BOTTOM"
    }
    static let coordinateSpaceName = "Scroll"
    let scrollTopAction: () -> Void
    let scrollBottomAction: () -> Void
    @Binding var offset: CGFloat
    @Binding var lastOffset: CGFloat
    
    var body: some View {
        GeometryReader { geo -> Color in
            let minY = geo.frame(in: .named(ScrollMovementOverlay.coordinateSpaceName)).minY
            let durationOffset: CGFloat = 35
            DispatchQueue.main.async {
                if minY < offset {
                    if offset < 0 && -minY > (lastOffset + durationOffset) {
                        withAnimation(.easeOut) {
                           scrollBottomAction()
                        }
                        lastOffset = -offset
                    }
                }
                if minY > offset && -minY < (lastOffset - durationOffset) {
                    withAnimation(.easeOut) {
                      scrollTopAction()
                    }
                    lastOffset = -offset
                }
                offset = minY
            }
            return Color.clear
        }
    }
}
