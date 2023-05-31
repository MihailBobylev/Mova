//
//  DeleteMovieBottonSheetView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 16.01.2023.
//

import SwiftUI

struct DeleteMovieBottomSheetView: View {
    let movie: FilmModel
    
    let cancelAction: () -> ()
    let confirmAction: () -> ()
    
    var body: some View {
        ZStack {
            Color(Color.SmallBottomSheet.background)
                .ignoresSafeArea()
                .cornerRadius(40, corners: [.topLeft, .topRight])
            VStack(spacing: 24.dvs) {
                DeleteMovieBottonSheetHandle()
                Text("Delete")
                    .font(.Urbanist.Bold.size(of: 24.dfs))
                    .foregroundColor(.SmallBottomSheet.titleText)
                HDeviderView()
                Text("Are you sure you want to delete this movie download?")
                    .font(.Urbanist.Bold.size(of: 20.dfs))
                    .foregroundColor(.SmallBottomSheet.descriptionText)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                DeletingMovieView(movie: movie)
                HDeviderView()
                SmallBottomButtonsView(cancelText: "Cancel", confirmText: "Yes, Delete") {
                    cancelAction()
                } confirmAction: {
                    confirmAction()
                }
                .padding(.bottom, 48.dvs)
            }
            .padding(.horizontal, 24.dhs)
        }
        .frame(height: 451.dvs)
    }
}

struct DeleteMovieBottonSheetHandle: View {
    var body: some View {
        Capsule()
            .foregroundColor(.SmallBottomSheet.detentHandle)
            .frame(width: 38.dhs, height: 3.dvs)
            .padding(.top, 8.dvs)
    }
}
