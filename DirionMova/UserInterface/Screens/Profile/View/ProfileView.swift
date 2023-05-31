//
//  ProfileView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 19.10.2022.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage(named: "person") ?? UIImage()
    @State private var isShowCountryCodes = false
    @State private var dragOffset: CGSize = .zero
    @State private var shouldShowDropdown = false
    
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color(Color.Profile.background)
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 140.dhs, height: 140.dvs)
                        
                        Image("edit")
                            .frame(width: 140.dhs, height: 140.dvs, alignment: .bottomTrailing)
                            .onTapGesture {
                                isShowPhotoLibrary.toggle()
                            }
                    }
                    .padding(.top, 34.dvs)
                    VStack(spacing: 24.dvs) {
                        NameTextFieldView(text: $profileViewModel.fullName, isTextFieldDataNotValid: $profileViewModel.isFullNameValid, titleKey: "Full Name", type: .fullName)
                        NameTextFieldView(text: $profileViewModel.nickName, isTextFieldDataNotValid: $profileViewModel.isNickNameValid, titleKey: "Nickname", type: .name)
                        EmailTextFieldView(text: $profileViewModel.email, type: .email)
                        PhoneTextFieldView(countryCode: $profileViewModel.phoneCode, countryFlag: $profileViewModel.countryFlag, phoneNumber: $profileViewModel.phone, type: .fullPhoneNumber, isShowCountryCodes: isShowCountryCodes) {
                            withAnimation (.easeOut) {
                                dragOffset = .zero
                                isShowCountryCodes.toggle()
                            }
                        }
                        GenderSelection(placeholder: "Gender")
                    }
                    .padding([.leading, .trailing, .top], 24.dhs)
                    Spacer()
                    ZStack {
                        Color(Color.Profile.background)
                            .ignoresSafeArea()
                        HStack {
                            Button("Skip") {
                                coordinator.show(.pin(flow: .create))
                            }
                            .buttonStyle(GrayButton())
                            .padding(.leading, 24.dhs)
                            .padding(.trailing, 12.dhs)
                            
                            Button("Continue") {
                                coordinator.show(.pin(flow: .create))
                            }
                            .buttonStyle(MovaButton())
                            .padding(.trailing, 24.dhs)
                        }
                    }
                    .frame(height: 58.dvs)
                    .padding([.top, .bottom], 28.dvs)
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: CustomBackButton())
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        HStack {
                            Text("Fill Your Profile")
                                .font(Font.Urbanist.Bold.size(of: 24))
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                    }
                }
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(selectedImage: $image)
                }
            }
            
            CountryCodeView(countryCode: $profileViewModel.phoneCode,
                            countryFlag: $profileViewModel.countryFlag,
                            isShowCountryCodes: $isShowCountryCodes)
            .opacity(isShowCountryCodes ? 1 : 0)
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
            isShowCountryCodes = false
            shouldShowDropdown = false
        }
        .contentShape(Rectangle())
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
