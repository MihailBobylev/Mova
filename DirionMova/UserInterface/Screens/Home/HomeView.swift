//
//  HomeView.swift
//  DirionMova
//
//  Created by Юрий Альт on 14.10.2022.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject private var homeViewModel = HomeViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @Environment(\.safeAreaInsets.top) private var safeAreaInsetsTop
    @Binding var tabSelection: String
    @State private var topBackImageOffset: CGFloat = 0
    
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(Color.Home.background)
                    .ignoresSafeArea()
                VStack {
                    TopBackImage(homeViewModel: homeViewModel, height: $topBackImageOffset, topLeftConstant: geo.frame(in: .global).minY)
                        .frame(width: geo.size.width)
                        .offset(x: 0, y: -100.dvs + (topBackImageOffset / 2).dvs)
                    Spacer()
                }
                ScrollView(showsIndicators: false) {
                    GeometryReader { innerGeo -> Text in
                        DispatchQueue.main.async {
                            topBackImageOffset = innerGeo.frame(in: .global).minY
                        }
                        return Text("")
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        HStack {
                            AppLogoView(size: 24)
                                .frame(width: 24, height: 24)
                                .padding(.leading, 24.dhs)
                            Spacer()
                            SearchButton(tabSelection: $tabSelection)
                            Button(action: { coordinator.show(.notification) }) {
                                Image("notificationCurved")
                            }
                        }
                        .padding(.trailing, 24.dhs)
                        .padding(.top, 34.dvs)
                        Spacer()
                        TitleView(homeViewModel: homeViewModel)
                        GenresView(homeViewModel: homeViewModel)
                        HStack {
                            PlayButtonView(action: {
                                coordinator.show(.player(movieID: homeViewModel.randomMovie.id.stringValue))
                            })
                            .padding(.trailing, 12.dhs)
                            if homeViewModel.myListState {
                                MyListButtonView(
                                    action: homeViewModel.myListAction,
                                    state: $homeViewModel.myListButtonState)
                            }
                        }
                        .padding(.leading, 24.dhs)
                        .padding(.bottom, 24.dvs)
                        .padding(.top, 8.dvs)
                    }
                    .frame(width: geo.size.width, height: geo.size.height * 0.4)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        openMovieDetails(with: homeViewModel.randomMovie.id)
                    }
                    ZStack {
                        Color(Color.Home.background)
                            .ignoresSafeArea()
                        MoviesGrid(homeViewModel: homeViewModel,
                                   openMovieDetailsAction: openMovieDetails,
                                   seeAllAction: seeAllAction)
                    }
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                
                VStack {
                    Rectangle()
                        .fill(Color(Color.Home.background))
                        .frame(height: safeAreaInsetsTop)
                        .ignoresSafeArea()
                    Spacer()
                }
                .opacity(homeViewModel.showHeader ? 1 : 0)
            }
        }
        .navigationBarHidden(true)
        .preferredColorScheme(.light)
    }
}


extension HomeView {
    private func seeAllAction(with type: MoviesGroupType) {
        coordinator.show(.actionMenu(type: type, tabSelected: $tabSelection))
    }
    
    private func openMovieDetails(with id: Int) {
        coordinator.show(.movieDetails(movieId: id))
    }
}

struct TopBackImage: View {
    @ObservedObject var homeViewModel: HomeViewModel
    @Binding var height: CGFloat
    let topLeftConstant: CGFloat
    
    var body: some View {
        KFImage(URL(string: homeViewModel.randomMovie.posterPath.getPosterImageURL(imageType: .poster(width: .original))))
            .resizable()
            .ignoresSafeArea()
            .scaledToFit()
            .blur(radius: getBlurRadiusForImage(height, topLeftConstant))
            .onAppear(
                perform: {
                    homeViewModel.getMovieData(for: .popularMovies)
                    homeViewModel.getMovieData(for: .topRatedMovies)
                    homeViewModel.getMovieData(for: .upcomingMovies)
                    homeViewModel.getMovieData(for: .nowPlayingMovies)
                }
            )
    }
    
    private func getBlurRadiusForImage(_ height: CGFloat, _ topLeftConstant: CGFloat) -> CGFloat {
        topLeftConstant == height ? 0 : abs(height)/50
    }
}

struct SearchButton: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @Binding var tabSelection: String
    
    var body: some View {
        Button(action: {
            tabSelection = "Explore"
        }) {
            Image("searchLightWhite")
        }
        .padding(.trailing, 30.dhs)
    }
}

struct TitleView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    var body: some View {
        Text(homeViewModel.randomMovie.title)
            .font(Font.Urbanist.Bold.size(of: 24.dfs))
            .foregroundColor(.Home.filmNameText)
            .padding(.leading, 24.dhs)
    }
}

struct GenresView: View {
    @ObservedObject var homeViewModel: HomeViewModel
    var body: some View {
        Text(homeViewModel.randomMovie.getGenreNames())
            .font(Font.Urbanist.Medium.size(of: 12.dfs))
            .foregroundColor(.Home.filmTagsText)
            .padding(.leading, 24.dhs)
            .padding(.top, 8.dvs)
    }
}

struct MoviesGrid: View {
    @Environment(\.safeAreaInsets.top) private var safeAreaInsetsTop
    @ObservedObject var homeViewModel: HomeViewModel
    var openMovieDetailsAction: (Int) -> Void
    var seeAllAction: (MoviesGroupType) -> Void
    
    private let columns = [GridItem(.flexible())]
    private let rows = [GridItem(.flexible())]
    
    var body: some View {
        VStack(spacing: 0) {
            LazyVGrid(columns: columns, pinnedViews: [.sectionHeaders]) {
                ForEach(homeViewModel.columnsData, id: \.self) { item in
                    Section {
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, spacing: 8.dhs) {
                                Spacer()
                                    .frame(width: 16.dhs, height: 200.dvs)
                                let movies = homeViewModel.getMovies(for: item)
                                createMoviesRow(with: movies)
                                Spacer()
                                    .frame(width: 16.dhs, height: 200.dvs)
                            }
                        }
                    } header: {
                        VStack(spacing: 0) {
                            ZStack {
                                Color(Color.Home.background)
                                GeometryReader { innerGeo -> Text in
                                    DispatchQueue.main.async {
                                        getHeightForStickyHeader(innerGeo.frame(in: .global).minY, item)
                                    }
                                    return Text("")
                                }
                                VStack(spacing: 0) {
                                    ZStack {
                                        HStack {
                                            Text(item.rawValue)
                                                .font(Font.Urbanist.Bold.size(of: 20.dfs))
                                                .foregroundColor(.Home.MovieColumnItem.categoriesText)
                                                .padding(.leading, 24.dhs)
                                            Spacer()
                                            Button(action: { seeAllAction(item) }) {
                                                Text("See all")
                                                    .font(Font.Urbanist.SemiBold.size(of: 14.dfs))
                                                    .foregroundColor(.Home.MovieColumnItem.seeAllButtonText)
                                                    .padding(.trailing, 24.dhs)
                                            }
                                        }
                                    }
                                }
                                .padding([.top, .bottom], 24.dvs)
                            }
                        }
                    }
                }
            }
            Spacer()
                .frame(height: 119.dvs)
        }
    }
    
    @ViewBuilder
    func createMoviesRow(with movies: [Movie]) -> some View {
        ForEach(movies, id: \.self) { movie in
            MovieCellView(action: { openMovieDetailsAction(movie.id) },
                          imageURL: movie.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                          rating: "\(movie.voteAverage.roundedStringValue)",
                          width: 150.dhs,
                          height: 200.dvs)
        }
    }
    
    private func getHeightForStickyHeader(_ minY: CGFloat, _ item: MoviesGroupType) {
        if homeViewModel.columnsData.first == item {
            homeViewModel.showHeader = minY <= safeAreaInsetsTop
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(tabSelection: .constant("Home"))
    }
}
