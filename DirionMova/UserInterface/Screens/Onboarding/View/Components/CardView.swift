//
//  CardView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/6/22.
//

import SwiftUI

struct CardView: View {
    
    var _title: String
    var _description: String
    var body: some View {
        VStack(spacing: 5.dvs){
            Spacer()
            Text(_title)
                .font(.Urbanist.Bold.size(of: 40.dfs))
                .foregroundColor(.white)
                
            Text(_description)
                .multilineTextAlignment(.center)
                .font(.Urbanist.Medium.size(of: 18.dfs))
                .foregroundColor(.white)
                .padding()
        }
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(_title: "",
                 _description: "")
    }
}
