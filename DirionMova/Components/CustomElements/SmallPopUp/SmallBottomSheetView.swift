//
//  SmallPopUpView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 02.12.2022.
//

import SwiftUI

struct SmallBottomSheetView: View {
    
    let title: String
    let description: String
    let cancelButtonText: String
    let confirmButtonText: String
    var height: CGFloat = 314.dvs
    
    let cancelAction: () -> ()
    let confirmAction: () -> ()
    
    var body: some View {
        ZStack {
            SmallBottomSheetBackground()
            VStack(spacing: 24.dvs) {
                SmallBottomSheetHandle()
                SmallBottomSheetTitle(title: title)
                HDeviderView()
                SmallBottomSheetDescription(description: description)
                HDeviderView()
                SmallBottomButtonsView(cancelText: cancelButtonText, confirmText: confirmButtonText) {
                    cancelAction()
                } confirmAction: {
                    confirmAction()
                }
                .padding(.bottom, 48.dvs)
            }
            .padding([.leading, .trailing], 24.dhs)
        }
        .frame(height: height)
    }
}

struct SmallBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallBottomSheetView(title: "Delete All Downloads", description: "Are you sure you want to delete all movies downloads?", cancelButtonText: "Cancel", confirmButtonText: "Confirm") {
            
        } confirmAction: {
            
        }
    }
}

struct SmallBottomSheetHandle: View {
    var body: some View {
        Capsule()
            .foregroundColor(.SmallBottomSheet.detentHandle)
            .frame(width: 38.dhs, height: 3.dvs)
            .padding(.top, 8.dvs)
    }
}

struct SmallBottomSheetTitle: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.Urbanist.Bold.size(of: 24.dfs))
            .foregroundColor(.SmallBottomSheet.titleText)
    }
}

struct SmallBottomSheetDescription: View {
    let description: String
    
    var body: some View {
        Text(description)
            .font(.Urbanist.Bold.size(of: 20.dfs))
            .foregroundColor(.SmallBottomSheet.descriptionText)
            .multilineTextAlignment(.center)
            .fixedSize(horizontal: false, vertical: true)
    }
}

struct SmallBottomButtonsView: View {
    let cancelText: String
    let confirmText: String
    
    let cancelAction: () -> ()
    let confirmAction: () -> ()
    
    var body: some View {
        HStack(spacing: 12.dhs) {
            //MARK: - Cancel Button
            Button(action: {
                cancelAction()
            }) {
                Text(cancelText)
            }
            .buttonStyle(GrayButton())
            //MARK: - Submit Button

            Button(action: {
                confirmAction()
            }) {
                Text(confirmText)
            }
            .buttonStyle(MovaButton())
        }
        .frame(height: 58.dvs)
    }
}

struct SmallBottomSheetBackground: View {
    var body: some View {
        Color(Color.SmallBottomSheet.background)
            .ignoresSafeArea()
            .cornerRadius(40, corners: [.topLeft, .topRight])
    }
}
