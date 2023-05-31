//
//  EditProfileView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 12/7/22.
//

import SwiftUI

struct EditProfileView: View {
    @State private var isGenderDropDownOpen = false
    @State private var isPhotoLibraryOpen = false
    @State private var isCountryCodeOpen = false
    @State private var isCountrySelectionOpen = false
    @State private var dragOffset: CGSize = .zero
    @ObservedObject private var viewModel = EditProfileViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color.EditProfile.background
                    .ignoresSafeArea()
                    .edgesIgnoringSafeArea(.all)
                    .navigationBarTitleDisplayMode(.inline)
                    .sheet(isPresented: $isPhotoLibraryOpen) {
                        ImagePicker(selectedImage: $viewModel.image)
                    }
                VStack(spacing: 24.dvs) {
                    ZStack {
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFill()
                            .frame(width: 140.dvs, height: 140.dvs)
                        
                        Image("edit")
                            .frame(width: 140.dhs, height: 140.dvs, alignment: .bottomTrailing)
                            .onTapGesture {
                                isPhotoLibraryOpen.toggle()
                            }
                    }
                    NameTextFieldView(text: $viewModel.fullNameText,
                                      isTextFieldDataNotValid: .constant(false),
                                      titleKey: "Full Name", type: .fullName)
                    NameTextFieldView(text: $viewModel.nickNameText,
                                      isTextFieldDataNotValid: .constant(false),
                                      titleKey: "Nickname", type: .name)
                    EmailTextFieldView(text: $viewModel.emailText,
                                       type: .email, iconPlacement: .right)
                    PhoneTextFieldView(countryCode: $viewModel.phoneCode,
                                       countryFlag: $viewModel.countryFlag,
                                       phoneNumber: $viewModel.phoneNumberText,
                                       type: .fullPhoneNumber,
                                       isShowCountryCodes: isCountryCodeOpen) {
                        withAnimation (.easeOut) {
                            dragOffset = .zero
                            isCountryCodeOpen.toggle()
                        }
                    }
                    GenderSelection(placeholder: "Gender")
                        .frame(height: 56.dvs)
                    CountryDropDown(selectedCountry: $viewModel.countryName,
                                    shouldShowDropdown: $isCountrySelectionOpen, placeholder: "Country") {
                        withAnimation (.easeOut) {
                            dragOffset = .zero
                            isCountrySelectionOpen.toggle()
                        }
                    }
                    Spacer()
                    Button("Update") {
                        viewModel.saveLocal()
                        UIApplication.shared.dismissKeyboard()
                        coordinator.pop()
                    }
                    .disabled(!viewModel.fieldsValid())
                    .opacity(viewModel.fieldsValid() ? 1 : 0.5)
                    .frame(height: 58.dvs, alignment: .center)
                    .padding([.leading, .trailing], 24.dhs)
                    .padding(.bottom, 48.dvs)
                    .buttonStyle(MovaButton())
                }
                .padding([.leading, .trailing], 24.dhs)
                
                CountryCodeView(countryCode: $viewModel.phoneCode,
                                countryFlag: $viewModel.countryFlag,
                                isShowCountryCodes: $isCountryCodeOpen)
                .opacity(isCountryCodeOpen ? 1 : 0)
                
                CountryCodeView(isShowCountryCodes: $isCountrySelectionOpen,
                                countryName: $viewModel.countryName,
                                type: .withoutCode)
                .opacity(isCountrySelectionOpen ? 1 : 0)
                
            }
            .onAppear {
                viewModel.loadUserData()
            }
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: CustomBackButton())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    EditProfileHeader()
                }
            }
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
        .contentShape(Rectangle())
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}

struct EditProfileHeader: View {
    
    var body: some View {
        HStack {
            Text("Edit Profile")
                .font(Font.Urbanist.Bold.size(of: 24.dfs))
                .multilineTextAlignment(.leading)
                .padding(.leading, 16.dhs)
            Spacer()
        }
    }
}
