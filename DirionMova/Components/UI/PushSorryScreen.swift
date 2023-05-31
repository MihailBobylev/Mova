//
//  PushSorryScreen.swift
//  DirionMova
//
//  Created by Mikhail on 11.10.2022.
//

import SwiftUI

struct PushSorryScreen: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Image("shieldLogo")
                .padding(.top, 40)
            
            VStack {
                Text("Sorry")
                    .font(.Urbanist.Bold.size(of: 24))
                    .foregroundColor(Color(UIColor.MOVA.primary500))
                    .padding(.bottom, 16)
                Text("Service is temporarily unavailable")
                    .font(.Urbanist.Regular.size(of: 16))
                    .foregroundColor(Color(UIColor.MOVA.greyscale900))
            }
            .padding(32)
            
            Button("OK") {
                action()
            }
            .frame(height: 58, alignment: .center)
            .buttonStyle(MovaButton())
            .padding([.leading, .trailing, .bottom], 32)
        }
        .frame(width: 340, height: 441)
        .background(
            Color.white
        )
        .cornerRadius(32)
    }
}

struct PushSorryScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        PushSorryScreen(){
            
        }
        
    }
}
