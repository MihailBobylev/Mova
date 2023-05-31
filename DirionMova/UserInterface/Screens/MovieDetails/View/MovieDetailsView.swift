//
//  MovieDetailsView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/20/22.
//

import SwiftUI
import Kingfisher

protocol MovieDetailsViewIxResponder {
    func openMovieDetails(movieId: Int)
}

struct MovieDetailsView: View {
    @StateObject var viewModel: MovieDetailsViewModel
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @EnvironmentObject var downloadManager: DownloadManager
    @Environment(\.safeAreaInsets.top) private var safeAreaInsetsTop
    @State private var isPresentSheet = false
    @State private var dragOffset: CGSize = .zero
    @State private var isDescriptionDisclosed = true
    @State private var topBackImageOffset: CGFloat = 0
    @State private var topLeftCorner: CGFloat = 0
    @State private var isDisplayedProgress = false
    
    var body: some View {
        GeometryReader { geo in
            if viewModel.isLoading {
                DetailsIndicatorView()
            } else {
                ZStack {
                    Color(Color.MovieDetails.background)
                        .ignoresSafeArea()
                    MovieTopBackImageView(viewModel: viewModel, topBackImageOffset: $topBackImageOffset, topLeftConstant: topLeftCorner)
                        .frame(width: geo.size.width)

                    ScrollViewReader { reader in
                        ScrollView(showsIndicators: true) {
                            GeometryReader { innerGeo -> Text in
                                DispatchQueue.main.async {
                                    topBackImageOffset = innerGeo.frame(in: .global).minY
                                }
                                return Text("")
                            }
                            HeaderTopButtonsView(coordinator: coordinator)
                            VStack {
                                HStack {
                                    MovieTitleView(viewModel: viewModel)
                                    Spacer()
                                    HStack(spacing: 20.dhs) {
                                        if !viewModel.isGuest {
                                            BookmarkButtonView(viewModel: viewModel)
                                        }
                                        ShareButton(viewModel: viewModel)
                                    }
                                }
                                .padding(.top, 24.dvs)
                                MoviePropertiesView(isPresentSheet: $isPresentSheet, dragOffset: $dragOffset, viewModel: viewModel)
                                    .padding(.top, 20.dvs)
                                DetailsLargeControlButtons(coordinator: coordinator, viewModel: viewModel, isPresentedBottomDownloadSheet: $viewModel.isPresentedBottomDownloadSheet)
                                    .padding(.top, 20.dvs)
                                GenresHView(viewModel: viewModel)
                                    .padding(.top, 20.dvs)
                                MovieOverviewView(viewModel: viewModel, isDescriptionDisclosed: $isDescriptionDisclosed)
                                ActorsList(actors: viewModel.actorsList)
                                    .padding(.horizontal, -24.dhs)
                                    .padding(.top, 20.dvs)
                                    .padding(.bottom, 24.dvs)
                                LazyVStack(spacing: 0, pinnedViews: [.sectionHeaders]) {
                                    Section {
                                        if viewModel.componentsIndex == 0 {
                                            TrailersList(viewModel: viewModel)
                                        } else if viewModel.componentsIndex == 1 {
                                            MoreLikeThisList(viewModel: viewModel)
                                        }
                                    } header: {
                                        GeometryReader { geo2 in
                                            VStack(spacing: 0) {
                                                Rectangle()
                                                    .fill(Color(Color.MovieDetails.background))
                                                    .frame(height: getHeightForStickyHeader(geo2.frame(in: .global).minY))
                                                MovieVideoDetailsButton(currentIndex: $viewModel.componentsIndex)
                                            }
                                        }
                                        .frame(height: 48.dvs)
                                        .padding(.bottom, 16.dvs)
                                    }
                                    .id("topSection")
                                    .onChange(of: viewModel.componentsIndex) { _ in
                                        reader.scrollTo("topSection", anchor: .center)
                                    }
                                }
                            }
                            .background(
                                Color(
                                    Color.MovieDetails.background)
                                    .padding(.horizontal, -24.dhs)
                            )
                            .padding(.horizontal, 24.dhs)
                        }
                        .ignoresSafeArea()
                    }
                    BottomSheetShadowBackView(isPresentSheet: $isPresentSheet)
                    BottomSheetView(viewModel: viewModel, isPresentSheet: $isPresentSheet, dragOffset: $dragOffset)
                    SmallBottomSheetShadowBackView(isPresentSheet: $viewModel.isPresentedBottomDownloadSheet) {
                        viewModel.isPresentedBottomDownloadSheet.toggle()
                    }
                    SmallBottomSheet(dragOffset: $viewModel.downloadBottomSheetDragOffset, isPresentSheet: viewModel.isPresentedBottomDownloadSheet, title: "Download", description: "Are you sure you want to download this movie?", cancelButtonText: "Cancel", confirmButtonText: "Yes, Download", height: 290.dvs) {
                        viewModel.isPresentedBottomDownloadSheet.toggle()
                    } confirmAction: {
                        guard let _posterPath = viewModel.detailsModel?.posterPath else {return}
                        
                        viewModel.isPresentedBottomDownloadSheet.toggle()
                        if downloadManager.checkTitleExists(name: _posterPath) {
                            viewModel.sendMovieExistNotification()
                            return
                        }
                        
                        isDisplayedProgress.toggle()
                        downloadManager.downloadMovie(movie: viewModel.detailsModel)
                    }
                    ProgressPopUpView(isDisplayed: $isDisplayedProgress, movie: viewModel.detailsModel)
                        .onChange(of: downloadManager.reloadDetailsScreenToggle) { _ in
                            if downloadManager.operations.isEmpty {
                                isDisplayedProgress = false
                            }
                        }
                    PopupWithButtonView(viewType: .noInternetConnection, isDisplayed: $viewModel.connectionLost)
                }
                .onAppear {
                    topLeftCorner = geo.frame(in: .global).minY
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func getHeightForStickyHeader(_ minY: CGFloat) -> CGFloat {
        var height: CGFloat = 0
        if minY <= safeAreaInsetsTop {
            height = safeAreaInsetsTop - minY >= 0 ? safeAreaInsetsTop - minY : safeAreaInsetsTop
        } else {
            height = 0
        }
        return height
    }
}

extension MovieDetailsView: MovieDetailsViewIxResponder {
    func openMovieDetails(movieId: Int) {
        coordinator.show(.movieDetails(movieId: movieId))
    }
}
//MARK: - Extension MovieDetailsView
extension MovieDetailsView {
    
    struct MovieTopBackImageView: View {
        @ObservedObject var viewModel: MovieDetailsViewModel
        @Binding var topBackImageOffset: CGFloat
        let topLeftConstant: CGFloat
        
        var body: some View {
            KFImage(viewModel.detailsModel?.getPosterPathURL)
                .resizable()
                .ignoresSafeArea()
                .scaledToFit()
                .blur(radius: getBlurRadiusForImage(topBackImageOffset, topLeftConstant))
                .offset(x: 0, y: -180 + (topBackImageOffset / 2))
        }
        
        private func getBlurRadiusForImage(_ height: CGFloat, _ topLeftConstant: CGFloat) -> CGFloat {
            topLeftConstant == height ? 0 : abs(height)/50
        }
    }
    
    struct MovieTitleView: View {
        @ObservedObject var viewModel: MovieDetailsViewModel
        
        var body: some View {
            VStack {
                MarqueeText(text: viewModel.detailsModel?.originalTitle ?? "")
                Spacer()
                    .frame(height: 20.dhs)
            }
            .padding(.trailing, 8.dhs)
        }
    }
    
    struct MovieOverviewView: View {
        @ObservedObject var viewModel: MovieDetailsViewModel
        @Binding var isDescriptionDisclosed: Bool
        
        var body: some View {
            Button(action: { isDescriptionDisclosed.toggle() }) {
                Text(viewModel.detailsModel?.overview ?? "")
                    .font(Font.Urbanist.Medium.size(of: 14.dfs))
                    .foregroundColor(.MovieDetails.descriptionText)
                    .lineLimit(isDescriptionDisclosed ? 3 : nil)
                    .multilineTextAlignment(.leading)
            }
        }
    }
    
    struct BookmarkButtonView: View {
        @ObservedObject var viewModel: MovieDetailsViewModel
        
        var body: some View {
            Button(action: viewModel.likeAction) {
                Image(viewModel.likeState ? "ic_like_active" : "ic_like")
            }
        }
    }
    
    struct ShareButton: View {
        @ObservedObject var viewModel: MovieDetailsViewModel
        
        var body: some View {
            Button(action: {
                guard let url = viewModel.detailsModel?.getImdbURL else { return }
                let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
                UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
                
            }) {
                Image("ic_send")
            }
        }
    }
}

struct MovieDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailsView(viewModel: .init(movieId: 22))
    }
}

struct MoviePropertiesView: View {
    @Binding var isPresentSheet: Bool
    @Binding var dragOffset: CGSize
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        HStack {
            Image("starRate\(Int(viewModel.detailsModel?.voteAverage ?? 0.0))")
                .resizable()
                .frame(width: 16.67.dhs, height: 15.83.dvs)
                .padding(.trailing, 4.dhs)
            Button(action: {
                isPresentSheet = true
                dragOffset = .zero
            }) {
                Text(viewModel.detailsModel?.voteAverage.roundedStringValue ?? "")
                    .font(Font.Urbanist.SemiBold.size(of: 12.dfs))
                    .foregroundColor(.MovieDetails.ratingLabelText)
            }
            Image("arrowRight2LightRed")
                .resizable()
                .frame(width: 16, height: 16)
                .padding(.leading, 4)
            Text(viewModel.detailsModel?.getReleaseYearString ?? "")
                .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                .padding(.leading, 4.dhs)
                .foregroundColor(.MovieDetails.yearLabelText)
            if !(viewModel.detailsModel?.getCertificate.isEmpty ?? true) {
                ParametersView(text: viewModel.detailsModel?.getCertificate ?? "")
                    .padding([.leading, .trailing], 8.dhs)
            }
            ParametersView(text: viewModel.detailsModel?.getFirstProductionCountry ?? "")
            Spacer()
        }
    }
}

struct BottomSheetShadowBackView: View {
    @Binding var isPresentSheet: Bool
    
    var body: some View {
        Color.PopupWithButtonView.background
            .ignoresSafeArea()
            .opacity(isPresentSheet ? 1 : 0)
            .animation(.easeIn)
            .onTapGesture {
                isPresentSheet = false
            }
    }
}

struct BottomSheetView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Binding var isPresentSheet: Bool
    @Binding var dragOffset: CGSize
    
    var body: some View {
        VStack {
            Spacer()
            RatingBottomSheetView(
                isPresented: $isPresentSheet,
                voteAvarage: viewModel.detailsModel?.voteAverage ?? 0.0,
                voteCount: viewModel.detailsModel?.voteCount ?? 0,
                movieId: viewModel.movieID,
                isGuest: viewModel.isGuest
            )
            .offset(y: isPresentSheet ? dragOffset.height : 800.0)
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
                        dragOffset.height = 800.0
                        isPresentSheet = false
                    } else {
                        dragOffset = .zero
                    }
                }
            )
        }
        .ignoresSafeArea()
    }
}

struct GenresHView: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        HStack {
            Text("Genre: \(viewModel.genres)")
                .font(Font.Urbanist.Medium.size(of: 14.dfs))
                .foregroundColor(.MovieDetails.genresText)
            Spacer()
        }
        .padding(.bottom, 8.dvs)
    }
}

struct DetailsIndicatorView: View {
    
    var body: some View {
        ZStack {
            Color(Color.Explore.background)
                .ignoresSafeArea()
            LoadingIndicatorView(size: 60)
                .frame(width: 60, height: 60, alignment: .center)
        }
    }
}

struct HeaderTopButtonsView: View {
    let coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        VStack {
            HStack {
                Button(action: { coordinator.pop() }) {
                    Image("arrowLeftLighWhite")
                        .frame(width: 28, height: 28)
                }
                .padding(.leading, 24.dhs)
                Spacer()
                Button(action: {}) {
                    Image("screenCast")
                        .frame(width: 28, height: 28)
                        .padding(.trailing, 24.dhs)
                }
            }
            .padding(.top, 34.dvs)
            Spacer()
        }
        .frame(height: 320.dvs)
    }
}

struct DetailsLargeControlButtons: View {
    let coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @ObservedObject var viewModel: MovieDetailsViewModel
    @Binding var isPresentedBottomDownloadSheet: Bool
    
    var body: some View {
        HStack {
            BigPlayButtonView(action: {
                coordinator.show(.player(movieID: viewModel.movieID.stringValue))
            })
            Spacer()
            DownloadButtonView(action: {
                isPresentedBottomDownloadSheet.toggle()
            })
            .disabled(viewModel.isGuest)
        }
    }
}
