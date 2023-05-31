//
//  ProfileAndSettingsView.swift
//  DirionMova
//
//  Created by Юрий Альт on 24.11.2022.
//

import SwiftUI

//MARK: - Root View
struct ProfileAndSettingsView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @StateObject private var viewModel = ProfileAndSettingsViewModel()
    @State private var isPhotoLibraryOpen = false
    @State private var selectedLanguage = "English (US)"
    
    @Binding var hideTabBar: Bool
    
    var body: some View {
        if viewModel.isGuest {
            GuestBlockView(action: coordinator.logout)
        } else {
            ZStack {
                Color(Color.ProfileAndSettingsView.background)
                    .sheet(isPresented: $isPhotoLibraryOpen) {
                        ImagePicker(selectedImage: $viewModel.image)
                    }
                VStack(spacing: 0) {
                    ProfileHeaderView()
                        .padding(.top, 34.dvs)
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0) {
                            ProfileImageWithEditButtonView(viewModel: viewModel, openPhotoLibrary: $isPhotoLibraryOpen)
                                .padding(.top, 24.dvs)
                            ProfileDataView(viewModel: viewModel)
                                .padding(.top, 12.dvs)
                            if !viewModel.isSubscribed {
                                MovaPremiumButton(action: {
                                    coordinator.show(.subscribeToPremium)
                                }, type: .join, hideDescription: false)
                                .frame(height: 113.dvs)
                            }
                        }
                        .padding(.horizontal, 24.dhs)
                        VStack(spacing: 20.dvs) {
                            ProfileNavigationMenuElement(type: .editProfile, action: { coordinator.show(.editProfile) })
                            if viewModel.isSubscribed {
                                ProfileNavigationMenuElement(type: .subscription, action: {})
                            }
                            ProfileNavigationMenuElement(type: .notification, action: { coordinator.show(.notificationSettings) })
                            ProfileNavigationMenuElement(type: .download, action: { coordinator.show(.download) })
                            ProfileNavigationMenuElement(type: .security, action: { coordinator.show(.security) })
                            ProfileNavigationMenuElement(type: .language, selectedLanguage: selectedLanguage, action: { coordinator.show(.language(language: $selectedLanguage)) })
                            ProfileNavigationMenuElement(type: .darkMode, action: {})
                            ProfileNavigationMenuElement(type: .helpCenter, action: { coordinator.show(.helpCenter) })
                            ProfileNavigationMenuElement(type: .privacyPolicy, action: { coordinator.show(.privacyPolicy) })
                            ProfileNavigationMenuElement(type: .logOut) {
                                hideTabBar.toggle()
                                viewModel.isPresentSheet.toggle()
                            }
                        }
                        .padding(.top, 26.dvs)
                        .padding(.horizontal, 24.dhs)
                        Spacer().frame(height: 109.dvs)
                    }
                }
                SmallBottomSheetShadowBackView(isPresentSheet: $viewModel.isPresentSheet) {
                    viewModel.isPresentSheet.toggle()
                    hideTabBar.toggle()
                }
                VStack {
                    Spacer()
                    SmallBottomSheet(dragOffset: $viewModel.dragOffset, isPresentSheet: viewModel.isPresentSheet, title: viewModel.bottomSheetTitle, description: viewModel.bottomSheetDesc, cancelButtonText: "Cancel", confirmButtonText: "Yes, Logout", height: 290.dvs) {
                        viewModel.isPresentSheet.toggle()
                        hideTabBar.toggle()
                    } confirmAction: {
                        viewModel.isPresentSheet.toggle()
                        hideTabBar.toggle()
                        coordinator.logout()
                    }
                }
            }
            .ignoresSafeArea()
            .onAppear {
                viewModel.isSubscribed = viewModel.checkSubscribtion()
                viewModel.loadUserData()
            }
        }
    }
}

//MARK: - Components
struct ProfileHeaderView: View {
    var body: some View {
        HStack {
            AppLogoView(size: 23.47)
                .frame(width: 23.47, height: 23.47)
                .padding(.leading, 28.27.dhs)
            Text("Profile")
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .foregroundColor(.ProfileAndSettingsView.titleText)
                .padding(.leading, 20.dhs)
            Spacer()
        }
        .padding(.top, 34.dvs)
    }
}

struct ProfileImageWithEditButtonView: View {
    @ObservedObject var viewModel: ProfileAndSettingsViewModel
    @Binding var openPhotoLibrary: Bool
    
    var body: some View {
        ZStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .clipShape(Circle())
                .frame(width: 120,height: 120)
            Button(action: {
                openPhotoLibrary.toggle()
            }) {
                Image("edit")
                    .frame(width: 120,height: 120, alignment: .bottomTrailing)
                    .padding([.bottom, .trailing], 2.5)
            }
        }
    }
}

struct ProfileDataView: View {
    @ObservedObject var viewModel: ProfileAndSettingsViewModel
    
    var body: some View {
        Group {
            Text(viewModel.fullName)
                .font(.Urbanist.Bold.size(of: 20.dfs))
                .foregroundColor(.ProfileAndSettingsView.fullNameText)
                .padding(.bottom, 8.dvs)
            Text(verbatim: viewModel.email)
                .font(.Urbanist.Medium.size(of: 14.dfs))
                .foregroundColor(.ProfileAndSettingsView.userNameText)
                .padding(.bottom, 24.dvs)
        }
    }
}

//MARK: - Preview
struct ProfileAndSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileAndSettingsView(hideTabBar: .constant(true))
    }
}
