//
//  MyListView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/3/22.
//
import SwiftUI

struct MyListView: View {
    @StateObject private var viewModel = MyListViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @State private var tabItemType = TabItemType.myList
    @State private var offset: CGFloat = 0
    @State private var lastOffset: CGFloat = 0
    @Binding var hideTabBar: Bool
    
    var body: some View {
        GeometryReader { _ in
            if viewModel.isGuest {
                GuestBlockView(action: coordinator.logout)
            } else {
                ZStack {
                    Color(Color.MyList.background)
                        .ignoresSafeArea()
                    VStack(spacing: 0) {
                        if viewModel.searchState {
                            MyListSearchBar(viewModel: viewModel, tabItemType: $tabItemType)
                                .padding(.top, 33.dvs)
                        } else {
                            MyListHeader(searchPressed: $viewModel.searchState)
                                .padding(.top, 33.dvs)
                                .padding(.bottom, 32.dvs)
                        }
                        if !viewModel.moviesList.isEmpty {
                            MyListCategories(isOpenDetails: viewModel.isOpenDetails, action: viewModel.filterByCategory)
                        }
                        if viewModel.moviesList.isEmpty {
                            Spacer()
                            VStack {
                                Image("ic_emptyList")
                                MyListEmptyTitle()
                                MyListEmptyDescription()
                            }
                            Spacer()
                        }
                        else if viewModel.myListMoviesList.isEmpty {
                            Spacer()
                            NotFoundScreen()
                                .onAppear {
                                    hideTabBar = false
                                }
                            Spacer(minLength: 200.dvs)
                        } else {
                            ScrollViewReader { reader in
                                ScrollView(showsIndicators: false) {
                                    MyListGrid(viewModel: viewModel, offset: $offset, lastOffset: $lastOffset, hideTabBar: $hideTabBar)
                                }
                                .onChange(of: viewModel.myListMoviesList, perform: { _myListMoviesList in
                                    reader.scrollTo(ScrollMovementOverlay.Move.top.rawValue, anchor: .top)
                                    lastOffset = 0
                                    offset = 0
                                    if _myListMoviesList.count <= 6 {
                                        hideTabBar = false
                                    }
                                })
                                .coordinateSpace(name: ScrollMovementOverlay.coordinateSpaceName)
                                .padding([.leading, .trailing], 24.dhs)
                                .padding(.top, 24.dvs)
                            }
                        }
                    }
                    .onAppear {
                        hideTabBar = false
                        if !viewModel.isOpenDetails {
                            viewModel.getMyList()
                        } else {
                            viewModel.isOpenDetails = false
                        }
                    }
                    .onDisappear {
                        if !viewModel.isOpenDetails {
                            viewModel.selectedGenres = [.allCategories]
                            viewModel.clearSearchBar()
                        }
                    }
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}


//MARK: - Subviews
struct MyListSearchBar: View {
    @ObservedObject var viewModel: MyListViewModel
    @Binding var tabItemType: TabItemType
    
    var body: some View {
        SearchBar(text: $viewModel.searchText, isFocused: $viewModel.isFocused, tabItemType: $tabItemType) {
            
        } commitAction: {
            
        } clearAction: {
            viewModel.clearSearchBar()
        }
        .animation(.easeIn(duration: 0.3))
        .transition(.slide)
        .padding(.bottom, 24.dvs)
        .padding(.horizontal, 24.dhs)
    }
}

struct MyListEmptyTitle: View {
    var body: some View {
        Text("Your List is Empty")
            .foregroundColor(Color.MyList.primaryText)
            .font(Font.Urbanist.SemiBold.size(of: 24))
            .padding(.top, 10)
    }
}

struct MyListEmptyDescription: View {
    var body: some View {
        Text("It seems that you haven't added \nany movies to the list")
            .multilineTextAlignment(.center)
            .foregroundColor(Color.MyList.descriptionText)
            .font(Font.Urbanist.Medium.size(of: 18))
            .padding([.leading, .trailing], 24)
            .padding(.top, 10)
    }
}

struct MyListGrid: View {
    @ObservedObject var viewModel: MyListViewModel
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @Binding var offset: CGFloat
    @Binding var lastOffset: CGFloat
    @Binding var hideTabBar: Bool
    
    var body: some View {
        LazyVGrid(columns: [
            GridItem(.flexible()),
            GridItem(.flexible())
        ], spacing: 8.dhs) {
            ForEach(viewModel.myListMoviesList, id: \.self) { index in
                MovieCellView(action: {
                    coordinator.show(.movieDetails(movieId: index.id))
                    viewModel.isOpenDetails = true
                },
                              removeListAction: { viewModel.likeAction(movieId: index.id, state: false) },
                              addListAction: { viewModel.likeAction(movieId: index.id, state: true) },
                              imageURL: index.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                              rating: index.voteAverage.roundedStringValue,
                              isLiked: true)
                .aspectRatio(contentMode: .fit)
            }
        }
        .id(ScrollMovementOverlay.Move.top.rawValue)
        .overlay(ScrollMovementOverlay(
            scrollTopAction: scrollTopAction,
            scrollBottomAction: scrollBottomAction,
            offset: $offset,
            lastOffset: $lastOffset))
        .padding(.bottom, 32.dvs)
    }
    
    
    private func scrollTopAction() {
        if hideTabBar {
            guard viewModel.isFocused == false else { return }
            viewModel.isFocused = false
            UIApplication.shared.dismissKeyboard()
            hideTabBar = false
        }
    }
    
    private func scrollBottomAction() {
        if !hideTabBar {
            viewModel.isFocused = false
            UIApplication.shared.dismissKeyboard()
            hideTabBar = true
        }
    }
}

//MARK: - Preview
struct MyListView_Previews: PreviewProvider {
    static var previews: some View {
        MyListView(hideTabBar: .constant(false))
    }
}
