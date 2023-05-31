//
//  SettingsDownloads.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 02.12.2022.
//

import SwiftUI

struct ProfileDownloads: View {
    enum SmallBottomSheetType {
        case download
        case cache
    }
    
    @State private var isPresentSheet = false
    @State private var dragOffset: CGSize = .zero
    @State private var bottomSheetTitle = ""
    @State private var bottomSheetDesc = ""
    @State private var bottomSheetType: SmallBottomSheetType = .download
    
    var body: some View {
        ZStack {
            Color.Download.background
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                VStack(spacing: 29.5.dvs) {
                    ProfileNavigationMenuElement(type: .wifiOnly, action: {})
                    ProfileNavigationMenuElement(type: .smartDownloads, action: {})
                    ProfileNavigationMenuElement(type: .videoQuality, action: {})
                    ProfileNavigationMenuElement(type: .audioQuality, action: {})
                    ProfileNavigationMenuElement(type: .deleteAllDownloads, action: {
                        bottomSheetTitle = "Delete All Downloads"
                        bottomSheetDesc = "Are you sure you want to delete all movies download?"
                        bottomSheetType = .download
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            isPresentSheet.toggle()
                        }
                        
                    })
                    ProfileNavigationMenuElement(type: .deleteCache, action: {
                        bottomSheetTitle = "Delete Cache"
                        bottomSheetDesc = "Are you sure you want to delete all cache?"
                        bottomSheetType = .cache
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                            isPresentSheet.toggle()
                        }
                    })
                    Spacer()
                }
                .padding(.top, 35.dvs)
                .padding(.horizontal, 24.dhs)
            
            SmallBottomSheetShadowBackView(isPresentSheet: $isPresentSheet) {
                isPresentSheet.toggle()
            }
            VStack(spacing: 0) {
                Spacer()
                SmallBottomSheet(dragOffset: $dragOffset, isPresentSheet: isPresentSheet, title: bottomSheetTitle, description: bottomSheetDesc, cancelButtonText: "Cancel", confirmButtonText: "Yes, Delete", height: getBottomSheetHeight()) {
                    isPresentSheet.toggle()
                } confirmAction: {
                    isPresentSheet.toggle()
                }
            }
            .ignoresSafeArea()
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Download")
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16.dhs)
                    Spacer()
                }
            }
        }
    }
    
    private func getBottomSheetHeight() -> CGFloat {
        switch bottomSheetType {
        case .download:
            return 314.dvs
        case .cache:
            return 290.dvs
        }
    }
}

struct ProfileDownloads_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDownloads()
    }
}

struct SmallBottomSheetShadowBackView: View {
    @Binding var isPresentSheet: Bool
    let tapAction: () -> ()
    
    var body: some View {
        Color.PopupWithButtonView.background
            .ignoresSafeArea()
            .opacity(isPresentSheet ? 1 : 0)
            .animation(.easeIn)
            .onTapGesture {
                tapAction()
            }
    }
}

struct SmallBottomSheet: View {
    @Binding var dragOffset: CGSize
    let isPresentSheet: Bool
    let title: String
    let description: String
    let cancelButtonText: String
    let confirmButtonText: String
    var height: CGFloat = 314.dvs
    
    let cancelAction: () -> ()
    let confirmAction: () -> ()
    
    var body: some View {
        VStack {
            Spacer()
            SmallBottomSheetView(title: title, description: description, cancelButtonText: cancelButtonText, confirmButtonText: confirmButtonText, height: height, cancelAction: {
                cancelAction()
            }, confirmAction: {
                confirmAction()
            })
            .offset(y: isPresentSheet ? dragOffset.height : UIScreen.main.bounds.maxY)
            .animation(.easeInOut)
            .gesture(DragGesture()
                .onChanged { value in
                    if value.translation.height < 0 {
                        dragOffset = .zero
                    } else {
                        dragOffset = value.translation
                    }
                }
                .onEnded { value in
                    if value.translation.height >= 150.0 {
                        dragOffset.height = .zero
                        cancelAction()
                    } else {
                        dragOffset = .zero
                    }
                }
            )
        }
        .ignoresSafeArea(.all)
    }
}
