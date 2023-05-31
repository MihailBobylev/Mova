//
//  ParametersView.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.11.2022.
//

import SwiftUI

struct ParametersView: View {
    
    let text: String
    
    var body: some View {
        ZStack {
            Text(text)
                .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                .foregroundColor(Color.MovieDetails.parametersViewText)
                .padding([.top, .bottom], 6.dvs)
                .padding([.leading, .trailing], 10.dhs)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(.MOVA.primary500), lineWidth: 1)
                )
            
        }
        .frame(height: 24.dvs)
    }
}

struct ParametersView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(UIColor.black)
            ParametersView(text: "18+")
                .frame(width: 100, height: 50)
        }
        
    }
}
