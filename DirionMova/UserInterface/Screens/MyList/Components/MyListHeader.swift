//
//  MyListHeader.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/9/22.
//

import SwiftUI

struct MyListHeader: View {
    
    @Binding var searchPressed: Bool
    
    var body: some View {
        HStack {
            AppLogoView(size: 24.dfs)
                .frame(width: 24.dhs, height: 24.dvs)
                .padding(.leading, 24.dhs)
            Text("My List")
                .font(Font.Urbanist.Bold.size(of: 24.dfs))
                .padding(.leading, 16.dhs)
                .foregroundColor(.MyList.titleText)
            Spacer()
            Button(action: { searchPressed = true }) {
                Image("searchLight")
            }
            .padding(.trailing, 24.dhs)
        }
        .animation(.easeOut(duration: 0.3))
        .transition(.slide)
        .frame(height: 48.dvs)
    }
}

struct MyListHeader_Previews: PreviewProvider {
    static var previews: some View {
        MyListHeader(searchPressed: .constant(false))
    }
}
