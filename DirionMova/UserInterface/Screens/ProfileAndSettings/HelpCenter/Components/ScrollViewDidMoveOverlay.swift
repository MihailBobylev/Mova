//
//  ScrollViewDidMoveOverlay.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//

import SwiftUI

struct ScrollViewDidMoveOverlay: View {
    @ObservedObject var faqViewModel: FAQViewModel
    @State var offset: CGFloat = 0
    let scrollAction: () -> ()
    
    var body: some View {
        GeometryReader { geo -> Color in
            let minY = geo.frame(in: .named("Scroll")).minY
            DispatchQueue.main.async {
                if minY != offset {
                    scrollAction()
                }
                offset = minY
            }
            return Color.clear
        }
    }
}
