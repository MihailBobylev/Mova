//
//  View+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/12/22.
//

import Foundation
import SwiftUI

extension View {
    func popup<T: View> (
        isPresented: Bool,
        alignment: Alignment = .center,
        direction: MovaPopup<T>.Direction = .bottom,
        @ViewBuilder content: () -> T) -> some View {
            modifier(MovaPopup(isPresented: isPresented, alignment: alignment, direction: direction, content: content))
        }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
