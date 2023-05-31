//
//  HomeViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 12.10.2022.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    //MARK: - Binding Properties
    lazy var myListState = !storage.isGuest
    @Published var myListButtonState = false
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var randomMovie = Movie(
        posterPath: "",
        backdropPath: "",
        genreIds: [],
        originalTitle: "",
        title: "",
        voteAverage: 0,
        id: 0
    )
    @Published var isGoToDetails: Bool = false
    @Published var showHeader = false
    var columnsData = MoviesGroupType.allCases
    
    //MARK: - Private Properties
    private let moviesDataFetchService = MoviesDataFetchService()
    private let listService = ListService()
    private var storage: CredentialsStorage = CredentialStorageImplementation()
    private var cancellableSet: Set<AnyCancellable> = []
    
    //MARK: - Public Methods
    func deletePin() {
        storage.clearStorage()
    }
    
    func getMovieData(for type: MoviesGroupType) {
        fetchMovieData(for: type)
            .flatMap { movies -> AnyPublisher<[Movie], Error> in
                if type == .popularMovies {
                    guard let randomPopularMovie = movies.randomElement() else {
                        return Fail(error: MovaError(statusCode: -1, statusMessage: "Error to get randomElement")).eraseToAnyPublisher()
                    }
                    self.randomMovie = randomPopularMovie
                    return self.checkMovieStatus(movieID: randomPopularMovie.id.stringValue)
                        .map { res -> [Movie] in
                            self.myListButtonState = res.itemPresent
                            return movies
                        }
                        .eraseToAnyPublisher()
                } else {
                    return Just(movies)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] movies in
                guard let self = self else { return }
                switch type {
                case .popularMovies:
                    self.popularMovies = movies
                case .topRatedMovies:
                    self.topRatedMovies = movies
                case .nowPlayingMovies:
                    self.nowPlayingMovies = movies
                case .upcomingMovies:
                    self.upcomingMovies = movies
                    print("+++Success fetch and decode films from data ? - \(movies)")
                }
            }
            .store(in: &cancellableSet)

    }
    
    private func fetchMovieData(for type: MoviesGroupType) -> AnyPublisher<[Movie], Error> {
        Future { [weak self] handler in
            guard let self = self else { return }
            self.moviesDataFetchService.getMovies(type: type, page: 1) { result in
                switch result {
                case .success(let data):
                    handler(.success(data.results))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getMovies(for type: MoviesGroupType) -> [Movie] {
        switch type {
        case .popularMovies:
            return popularMovies
        case .topRatedMovies:
            return topRatedMovies
        case .nowPlayingMovies:
            return nowPlayingMovies
        case .upcomingMovies:
            return upcomingMovies
        }
    }
    
    func myListAction() {
        let movieID = randomMovie.id.stringValue
        if myListButtonState {
            removeList(movieID: movieID)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { data in
                    self.myListButtonState = !data.success
                }
                .store(in: &cancellableSet)

        } else {
            addList(movieID: movieID)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { data in
                    self.myListButtonState = data.success
                }
                .store(in: &cancellableSet)
        }
    }
}

extension HomeViewModel {
    private func checkMovieStatus(movieID: String) -> AnyPublisher<CheckMovieStatusResponse, Error> {
        Future { [weak self] handler in
            guard let self = self, let listId = self.storage.listId else { return }
            self.listService.checkMovieStatus(movieID: movieID, listId: listId) { result in
                switch result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
     }
    
    private func addList(movieID: String) -> AnyPublisher<RemoveAndAddMovieResponse, Error> {
        Future { [weak self] handler in
            guard let self = self,
                  let listId = self.storage.listId,
                  let sessionId = self.storage.sessionID else { return }
            
            self.listService.addMovie(listId: listId,
                                 sessionId: sessionId,
                                 movieId: movieID) { result in
                switch result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func removeList(movieID: String) -> AnyPublisher<RemoveAndAddMovieResponse, Error> {
        Future { [weak self] handler in
            guard let self = self,
                  let listId = self.storage.listId,
                  let sessionId = self.storage.sessionID else { return }
            self.listService.removeMovie(listId: listId,
                                    sessionId: sessionId,
                                    movieId: movieID) { result in
                switch result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
