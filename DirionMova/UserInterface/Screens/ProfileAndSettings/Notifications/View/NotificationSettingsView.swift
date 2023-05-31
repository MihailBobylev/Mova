//
//  NotificationSettings.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 10.01.2023.
//

import SwiftUI

struct NotificationSettingsView: View {
    var body: some View {
        ZStack {
            Color.Download.background
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 28.dvs) {
                ProfileNavigationMenuElement(type: .generlNotification, action: {})
                ProfileNavigationMenuElement(type: .newArrival, action: {})
                ProfileNavigationMenuElement(type: .newServicesAvailable, action: {})
                ProfileNavigationMenuElement(type: .newReleasesMovie, action: {})
                ProfileNavigationMenuElement(type: .appUpdates, action: {})
                ProfileNavigationMenuElement(type: .subscriptionNotification, action: {})
                Spacer()
            }
            .padding(.top, 24.dvs)
            .padding(.horizontal, 24.dhs)
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Notification")
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16.dhs)
                    Spacer()
                }
            }
        }
    }
}

struct NotificationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingsView()
    }
}
