//
//  GuestBlockView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/30/22.
//

import SwiftUI

struct GuestBlockView: View {
    var action: () -> Void
    var body: some View {
        ZStack {
            Color(Color.MyList.background)
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Image("startLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 237.dhs, height: 200.dvs)
                    .padding(.bottom, 38.dvs)
                Text("You are currently in guest mode. To use all the \nfunctions of the application you must be \nlogged")
                    .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                    .padding([.leading, .trailing], 24.dhs)
                    .padding(.bottom, 60.dvs)
                    .multilineTextAlignment(.center)
                MovaPremiumButton(action: action, type: .sign)
                    .frame(height: 108.dvs)
                    .padding([.leading, .trailing], 24.dhs)
                Spacer(minLength: 200.dvs)
            }
        }
    }
}
