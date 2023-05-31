//
//  AppLogoView.swift
//  DirionMova
//
//  Created by Юрий Альт on 03.10.2022.
//

import SwiftUI

struct AppLogoView: View {
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: size / 4.5, y: 0))
                path.addLine(to: CGPoint(x: size / 4.5, y: size))
                path.addLine(to: CGPoint(x: 0, y: size))
            }
            .fill(Color.Logo.darkLine)
            
            Path { path in
                path.move(to: CGPoint(x: size / 1.29, y: 0))
                path.addLine(to: CGPoint(x: size, y: 0))
                path.addLine(to: CGPoint(x: size, y: size))
                path.addLine(to: CGPoint(x: size / 1.29, y: size))
            }
            .fill(Color.Logo.lightLine)
            
            Path { path in
                path.move(to: CGPoint(x: size / 2.54, y: size))
                path.addLine(to: CGPoint(x: size / 1.29, y: 0))
                path.addLine(to: CGPoint(x: size, y: 0))
                path.addLine(to: CGPoint(x: size / 1.63, y: size))
            }
            .fill(Color.Logo.darkLine)

            Path { path in
                path.move(to: CGPoint(x: 0, y: 0))
                path.addLine(to: CGPoint(x: size / 4.5, y: 0))
                path.addLine(to: CGPoint(x: size / 1.63, y: size))
                path.addLine(to: CGPoint(x: size / 2.54, y: size))
            }
            .fill(Color.Logo.lightLine)
        }
    }
}

struct AppLogoView_Previews: PreviewProvider {
    static var previews: some View {
        AppLogoView(size: 200)
    }
}
