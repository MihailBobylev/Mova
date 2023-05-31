//
//  NotFoundScreen.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 03.11.2022.
//

import SwiftUI

struct NotFoundScreen: View {
    var showDescription = true
    
    var body: some View {
        VStack {
            Image("notFound")
                .resizable()
                .scaledToFit()
                .frame(width: 300.dhs, height: 200.dvs)
            Text("Not Found")
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .foregroundColor(Color(UIColor.MOVA.primary500))
                .padding(.top, 44.dvs)
            if showDescription {
                Text("Sorry, the keyword you entered could not be found. Try to check again or search with other keywords.")
                    .font(.Urbanist.Medium.size(of: 18.dfs))
                    .padding(.top, 16.dvs)
                    .padding([.leading, .trailing], 24.dhs)
                    .multilineTextAlignment(.center)
            }
        }
        .background(Color(Color.Explore.notFoundBack))
    }
}

struct NotFoundScreen_Previews: PreviewProvider {
    static var previews: some View {
        NotFoundScreen()
    }
}
