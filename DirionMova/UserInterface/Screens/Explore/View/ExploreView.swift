//
//  ExploreView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

struct ExploreView: View {
    @StateObject private var exploreViewModel = ExploreViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @Binding var hideTabBar: Bool
    
    @State private var tabItemType = TabItemType.explore
    @State private var dragOffset: CGSize = .zero
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    let bottomEdge: CGFloat
    
    let movieRows = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let filterRows = [GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Color(Color.Explore.background)
                    .ignoresSafeArea()
                ZStack {
                    VStack(spacing: 0) {
                        HStack {
                            SearchBar(text: $exploreViewModel.searchTitle, isFocused: $exploreViewModel.isFocused, tabItemType: $tabItemType) {

                            } commitAction: {
                                
                            } clearAction: {
                                exploreViewModel.searchTitle = ""
                            }
                            Button(action: {
                                withAnimation (.easeOut) {
                                    UIApplication.shared.dismissKeyboard()
                                    hideTabBar = true
                                    exploreViewModel.isShowingFilters.toggle()
                                    dragOffset = .zero
                                }}) {
                                    Image("filterIcon")
                                }
                                .buttonStyle(FilterButton())
                        }
                        .padding([.leading, .trailing], 24.dhs)
                        .padding(.top, 24.dvs)
                        
                        if exploreViewModel.selectedFilters.count > 0 {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 8.dhs) {
                                    Spacer(minLength: 16.dhs)
                                    ForEach(exploreViewModel.selectedFilters, id: \.self) { selectedFilter in
                                        SelectedElement(text: selectedFilter) {
                                            exploreViewModel.currentPage = 1
                                            exploreViewModel.deletedElement = selectedFilter
                                            exploreViewModel.scrollToTopOnChange.toggle()
                                        }
                                    }
                                    Spacer(minLength: 16.dhs)
                                }
                                .frame(height: 38.dvs)
                            }
                            .padding(.top, 24.dvs)
                            .animation(.spring())
                        }
                        
                        ScrollViewReader { reader in
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: movieRows, spacing: 8.dvs) {
                                    ForEach(exploreViewModel.searchedMovies, id: \.self) { movie in
                                        MovieCellView(action: {
                                            UIApplication.shared.dismissKeyboard()
                                            exploreViewModel.isFocused = false
                                            exploreViewModel.isOpenDetails = true
                                            openMovieDetails(with: movie.id)
                                        },
                                                      imageURL: movie.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                                                      rating: "\(movie.voteAverage)"
                                        )
                                        .onAppear {
                                            exploreViewModel.loadMoreContent(movie: movie)
                                        }
                                        .aspectRatio(contentMode: .fit)
                                    }
                                }
                                .id(ScrollMovementOverlay.Move.top.rawValue)
                                .overlay(ScrollMovementOverlay(
                                    scrollTopAction: scrollTopAction,
                                    scrollBottomAction: scrollBottomAction,
                                    offset: $offset,
                                    lastOffset: $lastOffset))
                                .padding(.bottom, 15.dvs + 35.dvs + bottomEdge)
                            }
                            .onChange(of: exploreViewModel.scrollToTopOnChange, perform: { _ in
                                reader.scrollTo(ScrollMovementOverlay.Move.top.rawValue, anchor: .top)
                                lastOffset = 0
                                offset = 0
                            })
                            .onChange(of: exploreViewModel.searchedMovies, perform: { _searchedMovies in
                                print("=============================\(_searchedMovies.count) --- \(exploreViewModel.isReset)")
                                if _searchedMovies.count <= 6 && !exploreViewModel.isReset {
                                    hideTabBar = false
                                }
                            })
                            .coordinateSpace(name: ScrollMovementOverlay.coordinateSpaceName)
                            .padding([.leading, .trailing], 24.dhs)
                            .padding(.top, 24.dvs)
                            .opacity(exploreViewModel.isNotFound ? 0 : 1)
                        }
                    }
                    
                    NotFoundScreen()
                        .opacity(exploreViewModel.isNotFound ? 1 : 0)
                        .onChange(of: exploreViewModel.isNotFound) { newValue in
                            if newValue {
                                hideTabBar = false
                            }
                        }
                    Color(.MOVA.black.withAlphaComponent(0.7))
                        .ignoresSafeArea()
                        .opacity(exploreViewModel.isShowingFilters ? 1 : 0)
                        .animation(.easeIn(duration: 0.2))
                        .onTapGesture {
                            exploreViewModel.isShowingFilters.toggle()
                            hideTabBar = false
                        }
                    
                    VStack {
                        Spacer()
                        SortAndFilters(exploreViewModel: exploreViewModel) {
                            exploreViewModel.clearParams()
                            exploreViewModel.getDiscoverMovies()
                            exploreViewModel.isShowingFilters.toggle()
                        } applyAction: {
                            exploreViewModel.clearSearchField()
                            exploreViewModel.getDiscoverMovies()
                            exploreViewModel.isShowingFilters.toggle()
                        }
                        .cornerRadius(40, corners: [.topLeft, .topRight])
                        .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color(Color.Explore.sortBorder), lineWidth: 1))
                        .offset(y: exploreViewModel.isShowingFilters ? dragOffset.height.dvs: UIScreen.main.bounds.maxY)
                        .animation(.easeOut)
                        .gesture(DragGesture()
                            .onChanged { value in
                                if value.translation.height < 0 {
                                    dragOffset = .zero
                                } else {
                                    dragOffset = value.translation
                                }
                            }
                            .onEnded { value in
                                if value.translation.height >= 150.dvs {
                                    dragOffset.height = UIScreen.main.bounds.maxY
                                    exploreViewModel.isShowingFilters = false
                                } else {
                                    dragOffset = .zero
                                }
                            }
                        )
                    }
                    .ignoresSafeArea()
                    
                }
                .onAppear {
                    hideTabBar = false
                    if !exploreViewModel.isOpenDetails {
                        exploreViewModel.setup()
                    } else {
                        exploreViewModel.isOpenDetails = false
                    }
                }
                .onDisappear {
                    if !exploreViewModel.isOpenDetails {
                        exploreViewModel.clearParams()
                        exploreViewModel.clearSearchField()
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

extension ExploreView {
    private func scrollTopAction() {
        if hideTabBar {
            guard exploreViewModel.isFocused == false else { return }
            guard exploreViewModel.isShowingFilters == false else { return }
            exploreViewModel.isFocused = false
            UIApplication.shared.dismissKeyboard()
            hideTabBar = false
        }
    }
    
    private func scrollBottomAction() {
        if !hideTabBar {
            exploreViewModel.isFocused = false
            UIApplication.shared.dismissKeyboard()
            hideTabBar = true
        }
    }
    
    private func openMovieDetails(with id: Int) {
        coordinator.show(.movieDetails(movieId: id))
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(hideTabBar: .constant(false), bottomEdge: 40.0)
    }
}
