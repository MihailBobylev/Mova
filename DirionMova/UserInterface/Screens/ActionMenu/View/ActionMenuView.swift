//
//  ActionMenuView.swift
//  DirionMova
//
//  Created by Юрий Альт on 31.10.2022.
//

import SwiftUI

struct ActionMenuView: View {
    let actionMenuType: MoviesGroupType
    @Environment(\.presentationMode) var presentationMode
    @StateObject var actionMenuViewModel = ActionMenuViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @Binding var tabSelection: String
    
    var body: some View {
        ZStack {
            Color(Color.ActionMenu.background)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
                        Image("arrowLeftLight")
                            .frame(width: 28, height: 28)
                    }
                    Text(actionMenuType.rawValue)
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .padding(.leading, 20.dhs)
                        .foregroundColor(.ActionMenu.title)
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        tabSelection = "Explore"
                    }) {
                        Image("searchLight")
                    }
                    .padding(.trailing, 28.dhs)
                }
                .ignoresSafeArea()
                .padding(.top, 34.dvs)
                .padding(.leading, 28.dhs)
                .padding(.bottom, 34.dvs)
                
                ZStack {
                    ScrollView(showsIndicators: true) {
                        let columns = [GridItem(.flexible()), GridItem(.flexible())]
                        LazyVGrid(columns: columns, spacing: 8) {
                            switch actionMenuType {
                            case .popularMovies:
                                ForEach(actionMenuViewModel.popularMovies, id: \.self) { movie in
                                    MovieCellView(
                                        action: { coordinator.show(.movieDetails(movieId: movie.id)) },
                                        imageURL: movie.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                                        rating: movie.voteAverage.roundedStringValue
                                    )
                                    .onAppear(perform: {
                                        actionMenuViewModel.loadMoreContent(type: .popularMovies, movie: movie)
                                    })
                                    .aspectRatio(contentMode: .fit)
                                }
                            case .topRatedMovies:
                                ForEach(actionMenuViewModel.topRatedMovies, id: \.self) { movie in
                                    MovieCellView(
                                        action: { coordinator.show(.movieDetails(movieId: movie.id)) },
                                        imageURL: movie.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                                        rating: movie.voteAverage.roundedStringValue
                                    )
                                    .onAppear(perform: {
                                        actionMenuViewModel.loadMoreContent(type: .topRatedMovies, movie: movie)
                                    })
                                    .aspectRatio(contentMode: .fit)
                                }
                            case .upcomingMovies:
                                ForEach(actionMenuViewModel.upcomingMovies, id: \.self) { movie in
                                    MovieCellView(
                                        action: { coordinator.show(.movieDetails(movieId: movie.id)) },
                                        imageURL: movie.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                                        rating: movie.voteAverage.roundedStringValue
                                    )
                                    .onAppear(perform: {
                                        actionMenuViewModel.loadMoreContent(type: .upcomingMovies, movie: movie)
                                    })
                                    .aspectRatio(contentMode: .fit)
                                }
                            default:
                                ForEach(actionMenuViewModel.nowPlayingMovies, id: \.self) { movie in
                                    MovieCellView(
                                        action: { coordinator.show(.movieDetails(movieId: movie.id)) },
                                        imageURL: movie.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                                        rating: movie.voteAverage.roundedStringValue
                                    )
                                    .onAppear(perform: {
                                        actionMenuViewModel.loadMoreContent(type: .nowPlayingMovies, movie: movie)
                                    })
                                    .aspectRatio(contentMode: .fit)
                                }
                            }
                        }
                    }
                    .padding([.leading, .trailing], 24)
                    .navigationBarHidden(true)
                    .onAppear(perform: {
                        if actionMenuViewModel.isItFirstLoading {
                            actionMenuViewModel.getMovieData(for: self.actionMenuType, page: 1)
                        }
                    })
                }
            }
        }
    }
}

