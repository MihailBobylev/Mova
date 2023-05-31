//
//  MyListViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/3/22.
//

import SwiftUI
import Combine

class MyListViewModel: ObservableObject {
    @Published var searchText = "" {
        didSet {
            if let _searchText = searchTitleIsValid(title: searchText) {
                searchText = _searchText
            }
        }
    }
    var selectedGenres: [Genres] = [.allCategories]
    private let listService: ListServiceProtocol  = ListService()
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    @Published var moviesList: [ListGetDetailsItems] = []
    @Published var myListMoviesList: [ListGetDetailsItems] = []
    @Published var notFoundState = false
    @Published var isLoading = false
    @Published var searchState = false
    @Published var isFocused = false
    @Published var isOpenDetails = false
    lazy var isGuest = storage.isGuest
    
    private var isQueryValidPublisher: AnyPublisher<SearchState, Never> {
        $searchText
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { title in
                if title.isEmpty {
                    return .empty
                }
                if let _searchTitle = self.searchTitleIsValid(title: title) {
                    self.searchText = _searchTitle
                    return .invalid
                } else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        isQueryValidPublisher
            .sink { [weak self] searchState in
                guard let self = self else { return }
                switch searchState {
                case .valid:
                    self.searchAction()
                case .invalid:
                    break
                case .empty:
                    self.clearSearchBar()
                }
            }
            .store(in: &cancellableSet)
    }
    
    func getMyList() {
        fetchMyList()
            .map {
                $0.items
            }
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.myListMoviesList = items
                self.moviesList = items
                self.filterByCategory(genres: self.selectedGenres)
                if !self.searchText.isEmpty {
                    self.searchAction()
                }
            }
            .store(in: &cancellableSet)
    }
    
    private func fetchMyList() -> AnyPublisher<ListGetDetailsResponse, MovaError> {
        searchState = !searchText.isEmpty
        guard let id = storage.listId else {
            return Fail(error: MovaError(statusCode: -1, statusMessage: "listId is nil")).eraseToAnyPublisher()
        }
        if moviesList.isEmpty { isLoading = true }
        
        return Future { handler in
            self.listService.getListDetails(listId: id) { [weak self] result in
                guard let self = self else { return }
                self.isLoading = false
                switch result {
                case .success(let response):
                    handler(.success(response))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func likeAction(movieId: Int, state: Bool) {
        if state {
            addToList(movieId: movieId)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { res in
                    if res.success {
                        print("Movie added successfully")
                    }
                }
                .store(in: &cancellableSet)
        } else {
            removeFromList(movieId: movieId)
                .sink { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                    }
                } receiveValue: { res in
                    if res.success {
                        print("Movie deleted successfully")
                    }
                }
                .store(in: &cancellableSet)
        }
    }
    
    func filterByCategory(genres: [Genres]) {
        selectedGenres = genres
        getFilteredList()
    }
    
    func searchAction() {
        getFilteredList()
    }
    
    func clearSearchBar() {
        searchText = ""
        isFocused = false
        
        if selectedGenres == [.allCategories] {
            myListMoviesList = moviesList
        } else {
            let genresRawValues = selectedGenres.map { $0.rawValue }
            myListMoviesList = moviesList.filter { $0.genreIds.contains(where: genresRawValues.contains) }
        }
        
        searchState = false
    }
    
    func getFilteredList() {
        let genresRawValues = selectedGenres.map { $0.rawValue }
        if searchText.isEmpty {
            if selectedGenres == [.allCategories] {
                myListMoviesList = moviesList
            } else {
                myListMoviesList = moviesList.filter { $0.genreIds.contains(where: genresRawValues.contains) }
            }
        } else {
            if selectedGenres == [.allCategories] {
                myListMoviesList = moviesList.filter { $0.title.lowercased().contains(searchText.lowercased()) }
            } else {
                myListMoviesList = moviesList.filter { $0.title.lowercased().contains(searchText.lowercased()) && $0.genreIds.contains(where: genresRawValues.contains) }
            }
        }
    }
}

//MARK: - Helper functions
extension MyListViewModel {
    private func removeFromList(movieId: Int) -> AnyPublisher<RemoveAndAddMovieResponse, MovaError> {
        Future { handler in
            guard let listId = self.storage.listId,
                  let sessionId = self.storage.sessionID else {
                return
            }
            self.listService.removeMovie(listId: listId,
                                    sessionId: sessionId,
                                    movieId: movieId.stringValue) { result in
                switch result {
                case .success(let res):
                    handler(.success(res))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func addToList(movieId: Int) -> AnyPublisher<RemoveAndAddMovieResponse, MovaError> {
        Future { handler in
            guard let listId = self.storage.listId,
                  let sessionId = self.storage.sessionID else {
                return
            }
            self.listService.addMovie(listId: listId,
                                 sessionId: sessionId,
                                 movieId: movieId.stringValue) { result in
                switch result {
                case .success(let result):
                    handler(.success(result))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func searchTitleIsValid(title: String) -> String? {
        let lenght = title.count
        
        var _title = title.replacingOccurrences(
            of: "^ ",
            with: "",
            options: .regularExpression
        )
        _title = _title.replacingOccurrences(
            of: " {2,}",
            with: " ",
            options: .regularExpression
        )
        
        if lenght == _title.count {
            return nil
        } else {
            return _title
        }
    }
}
