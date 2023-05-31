//
//  MovaPopup.swift
//  DirionMova
//
//  Created by Mikhail on 11.10.2022.
//

import SwiftUI

struct MovaPopup<T: View>: ViewModifier {
    let popup: T
    let isPresented: Bool
    let alignment: Alignment
    let direction: Direction
    
    init(isPresented: Bool, alignment: Alignment, direction: Direction, @ViewBuilder content: () -> T) {
        self.popup = content()
        self.isPresented = isPresented
        self.alignment = alignment
        self.direction = direction
    }
    
    func body(content: Content) -> some View {
        content.overlay(popupContent())
    }
    
    @ViewBuilder private func popupContent() -> some View {
        GeometryReader { geo in
            if isPresented {
                popup
                    .animation(.spring())
                    .transition(.offset(x: 0, y: direction.offset(popupFrame: geo.frame(in: .global))))
                    .frame(width: geo.size.width, height: geo.size.height, alignment: alignment)
            }
        }
    }
}

extension MovaPopup {
    enum Direction {
        case top
        case bottom
        
        func offset(popupFrame: CGRect) -> CGFloat {
            switch self {
            case .top:
                let aboveScreenEdge = -popupFrame.maxY
                return aboveScreenEdge
            case .bottom:
                let belowScreenEdge = UIScreen.main.bounds.height - popupFrame.minY
                return belowScreenEdge
            }
        }
    }
}

