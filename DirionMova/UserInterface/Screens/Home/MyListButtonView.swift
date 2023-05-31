//
//  MyListButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

import SwiftUI

struct MyListButtonView: View {
    let action: () -> ()
    
    var body: some View {
        
        
        Button(action: action) {
            ZStack {
                Capsule()
                    .foregroundColor(Color.clear)
                    .frame(width: 100, height: 30)
                    .overlay(
                        Capsule().stroke(Color(UIColor.MOVA.greyscale200), lineWidth: 2)
                    )
                HStack {
                    Image("plus")
                    Text("My List")
                        .font(Font.Urbanist.SemiBold.size(of: 14))
                        .foregroundColor(Color.Home.playButtonText)
                }
            }
        }
        
    }
}

struct MyListButtonView_Previews: PreviewProvider {
    static var previews: some View {
        MyListButtonView(action: {})
    }
}
