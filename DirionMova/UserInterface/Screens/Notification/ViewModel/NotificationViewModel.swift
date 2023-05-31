//
//  NotificationViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 04.12.2022.
//

import Foundation
import RealmSwift
import Combine

class NotificationViewModel: ObservableObject {
    //MARK: - Binding Properties
    @Published var movies: [NotificationMovieDetailsResponse] = []
    
    //MARK: - Private Properties
    private let moviesDataFetchService = MoviesDataFetchService()
    private let storageManager = StorageManager()
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    private var cancellableSet: Set<AnyCancellable> = []
    
    //MARK: - Public Properties
    lazy var isGuest = storage.isGuest
    
    init() {
        getMovieChangesList()
    }
    
    //MARK: - Public Methods
    private func getMovieChangesList() {
        movies.removeAll()
        fetchMovieChangeList()
            .flatMap { changedMovies -> AnyPublisher<ChangedMovie, MovaError> in
                let notForAdultsMovieIDs = changedMovies.filter { $0.adult == false }
                let firstTwentyIDs = Array(notForAdultsMovieIDs.prefix(20))
                
                let publishers = firstTwentyIDs.map { [weak self] movie -> AnyPublisher<ChangedMovie, MovaError> in
                    guard let self = self else {
                        return Fail(error: MovaError(statusCode: -1, statusMessage: "Error to get self")).eraseToAnyPublisher()
                    }
                    
                    if self.storageManager.checkMovie(id: movie.id) {
                        return Just(movie)
                            .setFailureType(to: MovaError.self)
                            .eraseToAnyPublisher()
                    } else {
                        return self.fetchMovieDetails(id: movie.id)
                            .map { data -> ChangedMovie in
                                let newMovie = NotificationMovie()
                                newMovie.id = data.id
                                newMovie.originalTitle = data.originalTitle
                                newMovie.posterPath = data.posterPath ?? ""
                                newMovie.releaseDate = data.releaseDate
                                self.storageManager.saveMovie(movie: newMovie)
                                
                                return movie
                            }
                            .eraseToAnyPublisher()
                    }
                }
                
                return Publishers.Sequence(sequence: publishers)
                    .flatMap { publisher in
                        publisher
                    }
                    .eraseToAnyPublisher()
            }

            .sink { completion in
                if case .failure(let error) = completion {
                    print(error)
                }
            } receiveValue: { [weak self] movie in
                guard let self = self else { return }
                guard let storageMovie = self.storageManager.getMovie(movieId: movie.id) else { return }
                let newMovie = NotificationMovieDetailsResponse(
                    id: storageMovie.id,
                    originalTitle: storageMovie.originalTitle,
                    posterPath: storageMovie.posterPath,
                    releaseDate: storageMovie.releaseDate
                )
                self.movies.append(newMovie)
            }
            .store(in: &cancellableSet)
    }
    
    private func fetchMovieChangeList() -> AnyPublisher<[ChangedMovie], MovaError> {
        Future { [weak self] handler in
            guard let self = self else { return }
            self.moviesDataFetchService.getMoviesChangeList(page: 1) { result in
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
    
    private func fetchMovieDetails(id: Int) -> AnyPublisher<NotificationMovieDetailsResponse, MovaError> {
        Future { [weak self] handler in
            guard let self = self else { return }
            self.moviesDataFetchService.getNotificationMovieDetails(movieID: id.stringValue) { result in
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
