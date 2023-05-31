//
//  BigPlayButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 14.11.2022.
//

import SwiftUI

struct BigPlayButtonView: View {
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .frame(height: 38.dvs)
                    .foregroundColor(.MovieDetails.playButtonBack)
                HStack {
                    Image("playBold")
                        .frame(width: 20, height: 20)
                    Text("Play")
                        .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                        .foregroundColor(.MovieDetails.playButtonText)
                }
            }
        }
    }
}

struct BigPlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BigPlayButtonView(action: {})
    }
}
