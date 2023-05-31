//
//  PlayButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

import SwiftUI

struct PlayButtonView: View {
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .frame(width: 83.dhs, height: 32.dvs)
                    .foregroundColor(Color.Home.buttonPrimary)
                HStack {
                    Image("playBold")
                    Text("Play")
                        .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                        .foregroundColor(Color.Home.playButtonText)
                }
            }
        }
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView(action: {})
    }
}
