//
//  DownloadsView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/30/22.
//

import SwiftUI
import Kingfisher

struct DownloadsView: View {
    @StateObject var viewModel = DownloadsViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @EnvironmentObject var downloadManager: DownloadManager
    @State private var dragOffset: CGSize = .zero
    @Binding var hideTabBar: Bool
    
    let bottomEdge: CGFloat
    private let columns = [GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color.Download.background
                .ignoresSafeArea()
            
            if viewModel.isGuest {
                GuestBlockView(action: coordinator.logout)
            } else {
                VStack(spacing: 18.25.dvs) {
                    DownloadsHeaderView()
                        .padding(.top, 42.dvs)
                    if viewModel.movies.isEmpty {
                        Spacer()
                        VStack {
                            Image("ic_emptyList")
                            MyListEmptyTitle()
                        }
                        Spacer()
                    } else {
                        ScrollView(showsIndicators: false) {
                            Spacer()
                                .frame(height: 18.25.dvs)
                            LazyVGrid(columns: columns, spacing: 16.5.dvs) {
                                ForEach(viewModel.movies) { movie in
                                    DownloadsCellView(movie: movie) {
                                        coordinator.show(.loadPlayer(name: movie.imageName, title: movie.title))
                                    } deleteAction: {
                                        viewModel.delitingMovie = movie
                                        dragOffset = .zero
                                        hideTabBar = true
                                        withAnimation {
                                            viewModel.isPresentSheet = true
                                        }
                                    }
                                    .shimmer(isActive: !movie.isDownloaded)
                                }
                            }
                            Spacer()
                                .frame(height: 30.dvs + bottomEdge)
                        }
                        .onChange(of: downloadManager.reloadDownloadScreenToggle) { _ in
                            viewModel.loadData()
                        }
                    }
                }
                .padding(.horizontal, 24.dhs)
            }
            
            SmallBottomSheetShadowBackView(isPresentSheet: $viewModel.isPresentSheet) {
                switchToggles()
            }
            VStack(spacing: 0) {
                Spacer()
                DeleteMovieBottomSheet(dragOffset: $dragOffset, movie: viewModel.delitingMovie, isPresentSheet: viewModel.isPresentSheet) {
                    switchToggles()
                } confirmAction: { movie in
                    viewModel.deleteFilm(movie: movie)
                    switchToggles()
                }
            }
            .ignoresSafeArea()
            PopupWithButtonView(viewType: .noInternetConnection, isDisplayed: $viewModel.connectionLost)
                .onChange(of: viewModel.connectionLost) { newStatus in
                    hideTabBar = newStatus
                }
        }
        .onAppear {
            hideTabBar = false
            viewModel.isPresentSheet = false
            viewModel.setup(downloadManager)
            viewModel.loadData()
        }
    }
    
    func switchToggles() {
        hideTabBar = false
        withAnimation {
            viewModel.isPresentSheet = false
        }
    }
}

//MARK: - Subviews
struct DownloadsHeaderView: View {
    var body: some View {
        HStack {
            AppLogoView(size: 23.47)
                .frame(width: 23.47, height: 23.47)
            Text("Downloads")
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .foregroundColor(.Downloads.titleText)
                .padding(.leading, 16.dhs)
            Spacer()
            Button(action: {}) {
                Image("searchLight")
            }
        }
    }
}


//MARK: - Ячейка таблицы

struct DownloadsCellView: View {
    let movie: FilmModel
    
    let playAction: () -> ()
    let deleteAction: () -> ()
    
    var body: some View {
        HStack(spacing: 20.dhs) {
            makeImageView(movie: movie)
                .frame(width: 150.dhs, height: 112.5.dvs)
                .clipped()
                .cornerRadius(10)
                .overlay(
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.dhs, height: 24.dvs)
                )
                .onTapGesture {
                    if movie.isDownloaded {
                        playAction()
                    }
                }
            
            VStack(alignment: .leading, spacing: 12.dvs) {
                Text(movie.title)
                    .lineLimit(2)
                    .font(.Urbanist.Bold.size(of: 18.dfs))
                    .foregroundColor(.Downloads.filmNameText)
                
                Text("1h 42m 32s")
                    .font(.Urbanist.SemiBold.size(of: 14.dfs))
                    .foregroundColor(.Downloads.durationText)
                
                
                HStack {
                    Text(movie.fileSize)
                        .font(.Urbanist.SemiBold.size(of: 10.dfs))
                        .foregroundColor(.Downloads.fileSizeText)
                        .padding(.horizontal, 10.dhs)
                        .padding(.vertical, 6.dvs)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.Downloads.movieSizeBackground)
                        )
                    Spacer()
                    Button(action: deleteAction) {
                        Image("delete")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20.dhs, height: 20.dvs)
                    }
                }
                .opacity(movie.isDownloaded ? 1 : 0)
            }
        }
    }
    
    @ViewBuilder private func makeImageView(movie: FilmModel) -> some View {
        if let image = movie.image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            KFImage(URL(string: movie.imageName.getPosterImageURL(imageType: .poster(width: .original))))
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}

struct DeleteMovieBottomSheet: View {
    @Binding var dragOffset: CGSize
    let movie: FilmModel
    let isPresentSheet: Bool
    let cancelAction: () -> ()
    let confirmAction: (FilmModel) -> ()
    
    var body: some View {
        VStack {
            Spacer()
            DeleteMovieBottomSheetView(movie: movie, cancelAction: {
                cancelAction()
            }, confirmAction: {
                confirmAction(movie)
            })
            .offset(y: isPresentSheet ? dragOffset.height : UIScreen.main.bounds.maxY)
            .transition(.slide)
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
                        cancelAction()
                    } else {
                        dragOffset = .zero
                    }
                }
            )
        }
    }
}

//MARK: - Preview
struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadsView(hideTabBar: .constant(false), bottomEdge: 60.dvs)
    }
}
