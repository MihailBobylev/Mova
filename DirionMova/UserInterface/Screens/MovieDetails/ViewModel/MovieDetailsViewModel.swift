//
//  MovieDetailsViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/20/22.
//

import Foundation
import UserNotifications
import Combine

class MovieDetailsViewModel: ObservableObject {
    private let movieApi = MoviesDataFetchService()
    private let listService = ListService()
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    private let notificationManager = NotificationsManager()
    private var currentPage = 1
    private var totalPages = 0
    lazy var isGuest = storage.isGuest
    var actorsList: [ActorsModel] = []
    var trailerList: [MovieVideoResult] = []
    var genres = "No data"
    var detailsModel: MovieDetailsResponse?
    var movieID = 0
    
    @Published var isLoading = false
    @Published var similarMoviesList: [Movie] = []
    @Published var componentsIndex = 0
    @Published var likeState = false
    @Published var isNotFoundTrailers = false
    @Published var isNotFoundSimilars = false
    @Published var isPresentedBottomDownloadSheet = false
    @Published var downloadBottomSheetDragOffset: CGSize = .zero
    @Published var filmExists = false
    @Published var connectionLost = false
    
    private var cancellableSet: Set<AnyCancellable> = []

    init(movieId: Int) {
        self.movieID = movieId
        NotificationCenter.default.addObserver(self, selector: #selector(checkInternerConnection(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
        
        getMovieDetails()
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isNotFoundTrailers = true
                    print(error)
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.detailsModel = data
                self.filterActors()
                self.genres = data.getStringFormattedGenres
                if let trailers = data.videos?.results {
                    self.trailerList = trailers
                    self.isNotFoundTrailers = self.trailerList.isEmpty
                }
            }
            .store(in: &cancellableSet)
        
        checkMovieStatus(movieId: self.movieID.stringValue)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                self.likeState = data.itemPresent
            }
            .store(in: &cancellableSet)
        
        getSimilarMovies(page: currentPage)
    }
    
    func loadMoreContent(movie: Movie) {
        let thresholdIndex = self.similarMoviesList.last?.id
        if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
            currentPage += 1
            getSimilarMovies(page: currentPage)
        }
    }
    
    func likeAction() {
        let movieId = self.movieID.stringValue
        if self.likeState {
            removeFromList(movieID: movieId)
        } else {
            addToList(movieID: movieId)
        }
    }
    
    func getSimilarMovies(page: Int) {
        fetchSimilarMovies(page: page)
            .receive(on: RunLoop.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isNotFoundSimilars = true
                    print(error)
                }
            } receiveValue: { [weak self] data in
                guard let self = self else { return }
                print("### \(data.results)")
                self.similarMoviesList.append(contentsOf: data.results)
                self.totalPages = data.totalPages
                self.isNotFoundSimilars = self.similarMoviesList.isEmpty
            }
            .store(in: &cancellableSet)
    }
}

extension MovieDetailsViewModel {
    private func checkMovieStatus(movieId: String) -> AnyPublisher<CheckMovieStatusResponse, MovaError> {
        Future { [weak self] handler in
            guard let self = self,
                  let listId = self.storage.listId else { return }
            self.listService.checkMovieStatus(movieID: movieId, listId: listId) { result in
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
    
    private func addToList(movieID: String) {
        guard let listId = storage.listId,
              let sessionId = storage.sessionID else { return }
        
        listService.addMovie(listId: listId,
                             sessionId: sessionId,
                             movieId: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.likeState = data.success
            case .failure(let error):
                debugPrint("addMovie failed with \(error)")
            }
        }
    }
    
    private func removeFromList(movieID: String) {
        guard let listId = storage.listId,
              let sessionId = storage.sessionID else { return }
        
        listService.removeMovie(listId: listId,
                                sessionId: sessionId,
                                movieId: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.likeState = !data.success
            case .failure(let error):
                debugPrint("removeFromList failed with \(error)")
            }
        }
    }
    
    private func getMovieDetails() -> AnyPublisher<MovieDetailsResponse, MovaError> {
        Future { [weak self] handler in
            guard let self = self else { return }
            self.isLoading = true
            self.movieApi.getMovieDetails(movieID: self.movieID.stringValue) { result in
                switch result {
                case .success(let data):
                    handler(.success(data))
                case .failure(let error):
                    handler(.failure(error))
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.isLoading = false
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func fetchSimilarMovies(page: Int) -> AnyPublisher<GetMoviesResponse, MovaError> {
        Future { [weak self] handler in
            guard let self = self else { return }
            self.movieApi.getSimilarMovies(movieID: self.movieID.stringValue, page: page) { result in
                switch result {
                case .success(let data):
                    print("### success")
                    handler(.success(data))
                case .failure(let error):
                    print("### failure")
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension MovieDetailsViewModel {
    private func filterActors() {
        guard let cast = self.detailsModel?.credits.cast,
              let crew = self.detailsModel?.credits.crew else { return }
        
        let actoredCast = cast.map {
            ActorsModel(
                name: $0.originalName ?? "",
                job: $0.knownForDepartment ?? "",
                picturePath: $0.profilePath ?? "")
        }
        let directors = crew.filter { ActorType.director.title.contains($0.job ?? "") }
        let writers = crew.filter {  ActorType.writer.title.contains($0.job ?? "") }
        let producers = crew.filter { ActorType.producer.title.contains($0.job ?? "") }
        
        let actoredCrew = [directors, writers, producers].joined().map {
            ActorsModel(
                name: $0.originalName ?? "",
                job: $0.job ?? "",
                picturePath: $0.profilePath ?? "")
        }
        actorsList.append(contentsOf: actoredCrew)
        actorsList.append(contentsOf: actoredCast)
    }
}

extension MovieDetailsViewModel {
    func sendMovieExistNotification() {
        notificationManager.sendMovieExistNotification()
    }
    
    @objc func checkInternerConnection(notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.connectionLost = !NetworkMonitor.shared.isConnected
        }
    }
}

