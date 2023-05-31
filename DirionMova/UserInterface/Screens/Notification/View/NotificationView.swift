//
//  NotificationView.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.12.2022.
//

import SwiftUI

struct NotificationView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @StateObject private var viewModel = NotificationViewModel()
    @State private var isSorryTopupDisplayed = false
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color(Color.Notification.background)
                .ignoresSafeArea()
            if viewModel.isGuest {
                VStack(spacing: 0) {
                    NotificationBackButtonView()
                    GuestBlockView(action: coordinator.logout)
                }
            } else {
                VStack(spacing: 0) {
                    HStack {
                        Button(action: { coordinator.pop() }) {
                            Image("arrowLeftLight")
                        }
                        Text("Notification")
                            .padding(.leading, 16.dhs)
                            .font(.Urbanist.Bold.size(of: 24.dfs))
                            .foregroundColor(.SelectResetContact.titleText)
                        Spacer()
                        Button(action: { isSorryTopupDisplayed.toggle() }) {
                            Image("more")
                        }
                    }
                    .padding(.vertical, 34.dvs)
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 24.dvs) {
                            ForEach(viewModel.movies, id: \.uuid) { item in
                                NotificationCellView(
                                    action: { coordinator.show(.movieDetails(movieId: item.id)) },
                                    imageURL: item.posterPath?.getPosterImageURL(imageType: .poster(width: .w154)) ?? "",
                                    name: item.originalTitle,
                                    date: item.releaseDate.getMMddyyyyString
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal, 24.dhs)
                PopupWithButtonView(viewType: .serviceIsTemporaryUnavailable, isDisplayed: $isSorryTopupDisplayed)
            }
        }
        
    }
}

//MARK: - Subviews
struct NotificationBackButtonView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        HStack {
            Button(action: { coordinator.pop() }) {
                Image("arrowLeftLight")
                    .frame(width: 28, height: 28)
            }
            .padding(.top, 34.dvs)
            .padding(.leading, 28.dhs)
            Spacer()
        }
    }
}

//MARK: - Preview
struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
