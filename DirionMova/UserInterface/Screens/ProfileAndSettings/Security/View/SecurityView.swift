//
//  SecurityView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 10.01.2023.
//

import SwiftUI

struct SecurityView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.Download.background
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading, spacing: 27.dvs) {
                Text("Control")
                    .font(.Urbanist.Bold.size(of: 20.dfs))
                ProfileNavigationMenuElement(type: .securityAlerts, action: {})
                ProfileNavigationMenuElement(type: .manageDevices, action: {})
                ProfileNavigationMenuElement(type: .managePermission, action: {})
                Text("Security")
                    .font(.Urbanist.Bold.size(of: 20.dfs))
                ProfileNavigationMenuElement(type: .rememberMe, action: {})
                ProfileNavigationMenuElement(type: .faceID, action: {})
                ProfileNavigationMenuElement(type: .biometricID, action: {})
                ProfileNavigationMenuElement(type: .googleAuthenticator, action: {})
                
                VStack(spacing: 27.dvs) {
                    Button {

                    } label: {
                        Text("Change PIN")
                    }
                    .frame(height: 58.dvs, alignment: .center)
                    .buttonStyle(AddCardStyle())

                    Button {

                    } label: {
                        Text("Change Password")
                    }
                    .frame(height: 58.dvs, alignment: .center)
                    .buttonStyle(AddCardStyle())
                }
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
                    Text("Security")
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16.dhs)
                    Spacer()
                }
            }
        }
    }
}

struct SecurityView_Previews: PreviewProvider {
    static var previews: some View {
        SecurityView()
    }
}
