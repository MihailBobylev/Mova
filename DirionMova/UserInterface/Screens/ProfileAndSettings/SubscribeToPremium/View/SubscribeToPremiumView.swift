//
//  SubscribeToPremiumView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 15.12.2022.
//

import SwiftUI

struct SubscribeToPremiumView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.SubscribeToPremium.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Text("Subscribe to Premium")
                    .font(.Urbanist.Bold.size(of: 32.dfs))
                    .foregroundColor(.SubscribeToPremium.subscribeToPremiumText)
                    .padding(.bottom, 12.dvs)
                Text("Enjoy watching Full-HD movies, without restrictions and without ads")
                    .multilineTextAlignment(.center)
                    .font(.Urbanist.Medium.size(of: 16.dfs))
                    .foregroundColor(.SubscribeToPremium.rowText)
                    .padding(.bottom, 24.dvs)
                    .padding(.horizontal, 24.dhs)
                SubscribeToPremiumButton(type: .month) {
                    coordinator.show(.payment(rate: .month))
                }
                .padding(.bottom, 24.dvs)
                SubscribeToPremiumButton(type: .year) {
                    coordinator.show(.payment(rate: .year))
                }
            }
            .padding(.horizontal, 24.dhs)
            .padding(.top, 24.dvs)
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
    }
}

struct SubscribeToPremiumView_Previews: PreviewProvider {
    static var previews: some View {
        SubscribeToPremiumView()
    }
}
