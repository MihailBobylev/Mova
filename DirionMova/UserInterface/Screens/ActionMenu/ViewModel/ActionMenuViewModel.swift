//
//  ActionMenuViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 31.10.2022.
//

import Foundation

class ActionMenuViewModel: ObservableObject {
    //MARK: - Binding Properties
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var isLoading = true
    @Published var isItFirstLoading = true
    
    //MARK: - Private Properties
    private let moviesDataFetchService = MoviesDataFetchService()
    private var currentPage = 1
    private var totalPages = 0
    
    //MARK: - Public Methods
    func loadMoreContent(type: MoviesGroupType, movie: Movie) {
        switch type {
        case .popularMovies:
            let thresholdIndex = popularMovies.last?.id
            if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
                currentPage += 1
                getMovieData(for: type, page: currentPage)
            }
        case .topRatedMovies:
            let thresholdIndex = topRatedMovies.last?.id
            if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
                currentPage += 1
                getMovieData(for: type, page: currentPage)
            }
        case .upcomingMovies:
            let thresholdIndex = upcomingMovies.last?.id
            if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
                currentPage += 1
                getMovieData(for: type, page: currentPage)
            }
        case .nowPlayingMovies:
            let thresholdIndex = nowPlayingMovies.last?.id
            if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
                currentPage += 1
                getMovieData(for: type, page: currentPage)
            }
        }
    }
    
    func getMovieData(for type: MoviesGroupType, page: Int) {
        isLoading = true
        moviesDataFetchService.getMovies(type: type, page: page) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.totalPages = data.totalPages
                switch type {
                case .popularMovies:
                    self.popularMovies.append(contentsOf: data.results)
                case .topRatedMovies:
                    self.topRatedMovies.append(contentsOf: data.results)
                case .upcomingMovies:
                    self.upcomingMovies.append(contentsOf: data.results)
                case .nowPlayingMovies:
                    self.nowPlayingMovies.append(contentsOf: data.results)
                }
                print("+++Success fetch and decode films from data ? - \(data.results)")
            case .failure(let error):
                print(error)
            }
            self.isLoading = false
            self.isItFirstLoading = false
        }
    }
}
