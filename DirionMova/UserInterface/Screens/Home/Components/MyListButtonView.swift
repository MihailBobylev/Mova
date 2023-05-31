//
//  MyListButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

import SwiftUI

struct MyListButtonView: View {
    let action: () -> ()
    @Binding var state: Bool
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .foregroundColor(state ? Color.Home.buttonPrimary : Color.clear)
                    .frame(width: 102.dhs, height: 32.dvs)
                    .overlay(
                        Capsule()
                            .stroke(
                                state ? Color(UIColor.clear) : Color(UIColor.MOVA.greyscale200), lineWidth: 2
                            )
                    )
                HStack {
                    Image(state ? "heartWhite" : "plus")
                    Text("My List")
                        .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                        .foregroundColor(Color.Home.playButtonText)
                }
            }
        }
    }
}

struct MyListButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MyListButtonView(action: {}, state: .constant(false))
    }
}
