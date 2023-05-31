//
//  ProfileNavigationMenuElement.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/28/22.
//

import SwiftUI

struct ProfileNavigationMenuElement: View {
    
    @State private var toggleIsOn = false
    let type: ProfileMenuElementType
    var selectedLanguage: String?
    let action: () -> ()
    
    var body: some View {
        switch type {
        case .darkMode, .wifiOnly:
            HStack {
                Image(type.imageName)
                    .resizable()
                    .frame(width: 28, height: 28)
                Text(verbatim: type.title)
                    .font(.Urbanist.SemiBold.size(of: 18.dfs))
                    .foregroundColor(.ProfileAndSettingsView.menuElementText)
                    .padding(.leading, 20.dhs)
                Spacer()
                MovaToggle(isOn: $toggleIsOn)
            }
        case .generlNotification, .newArrival, .newServicesAvailable, .newReleasesMovie,
                .appUpdates, .subscriptionNotification, .rememberMe, .faceID, .biometricID:
            HStack {
                Text(verbatim: type.title)
                    .font(.Urbanist.SemiBold.size(of: 18.dfs))
                    .foregroundColor(.ProfileAndSettingsView.menuElementText)
                Spacer()
                MovaToggle(isOn: $toggleIsOn)
            }
        case .securityAlerts, .manageDevices, .managePermission, .googleAuthenticator:
            Button {
                action()
            } label: {
                HStack {
                    Text(verbatim: type.title)
                        .font(.Urbanist.SemiBold.size(of: 18.dfs))
                        .foregroundColor(getTextColor())
                    Spacer()
                    Image("arrowRightBlack")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        default:
            Button(action: action) {
                HStack {
                    Image(type.imageName)
                        .resizable()
                        .frame(width: 28, height: 28)
                    Text(verbatim: type.title)
                        .font(.Urbanist.SemiBold.size(of: 18.dfs))
                        .foregroundColor(type == .logOut ? .ProfileAndSettingsView.logOutMenuElementText : .ProfileAndSettingsView.menuElementText)
                        .padding(.leading, 20.dhs)
                    switch type {
                    case .logOut, .deleteCache, .deleteAllDownloads:
                        Spacer()
                    default:
                        Spacer()
                        if type == .language {
                            Text(verbatim: selectedLanguage ?? "English (US)")
                                .font(.Urbanist.SemiBold.size(of: 18.dfs))
                                .foregroundColor(.ProfileAndSettingsView.menuElementText)
                                .padding(.trailing, 20.dhs)
                        }
                        Image("arrowRightBlack")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
    
    func getTextColor() -> Color {
        switch type {
        case .securityAlerts, .manageDevices, .managePermission:
            return .Security.tileControlText
        default:
            return .Security.tileSecurityText
        }
    }
}
