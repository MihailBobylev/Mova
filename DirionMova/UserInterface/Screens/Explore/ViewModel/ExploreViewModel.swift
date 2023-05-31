//
//  ExploreViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import UIKit
import Combine

class ExploreViewModel: ObservableObject {
    @Published var isFocused = false
    @Published var isNotFound = false
    @Published var isShowingFilters = false
    @Published var selectedFilters: [String] = []
    @Published var deletedElement = ""
    @Published var searchedMovies: [Movie] = []
    let timePeriods = ["All Periods","2022","2021","2020", "2019", "2018",
                                  "2017", "2016", "2015", "2014", "2013", "2012",
                                  "2011", "2010", "2009", "2008", "2007", "2006",
                                  "2005", "2004", "2003", "2002", "2001", "2000",
                                  "1999", "1998", "1997", "1996", "1995", "1994",
                                  "1993", "1992", "1991", "1990", "1989", "1988",
                                  "1987", "1986", "1985", "1984", "1983", "1982",
                                  "1981", "1980", "1979", "1978", "1977", "1976",
                                  "1975", "1974", "1973", "1972", "1971", "1970",
                                  "1969", "1968", "1967", "1966", "1965", "1964",
                                  "1963", "1962", "1961", "1960"]
    @Published var genres: [Genre] = []
    @Published var searchTitle = "" {
        didSet {
            if let _searchTitle = searchTitleIsValid(title: searchTitle) {
                searchTitle = _searchTitle
            }
        }
    }
    @Published var isReset = false
    @Published var isLoading = true
    @Published var isOpenDetails = false
    @Published var scrollToTopOnChange = false
    
    var requestParameters: [String: Any] = [
        "api_key": ServerConstants.apiKey,
        "language": "en-US"
    ]
    
    @Published var category = CategoryTypes.empty
    @Published var year: String = ""
    @Published var withGenres: [String] = []
    @Published var sortBy = SortTypes.empty
    @Published var currentSearchType = SearchType.filterSearch
    
    public var currentPage = 1
    private let searchService = SearchService()
    private let moviesDataFetchService = MoviesDataFetchService()
    private let discoverService = DiscoverService()
    private let genreService = GenreService()
    private var totalPages = 0
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isQueryValidPublisher: AnyPublisher<SearchState, Never> {
        $searchTitle
            .debounce(for: 1, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map { title in
                if title.isEmpty {
                    return .empty
                }
                if let _searchTitle = self.searchTitleIsValid(title: title) {
                    self.searchTitle = _searchTitle
                    return .invalid
                } else {
                    return .valid
                }
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isQueryValidPublisher
            .dropFirst()
            .sink { [weak self] searchState in
                guard let self = self else { return }
                switch searchState {
                case .valid:
                    self.clearParams()
                    self.currentSearchType = .titleSearch
                    self.getSearchedMovies(title: self.searchTitle, page: 1)
                case .invalid:
                    break
                case .empty:
                    self.clearParams()
                    self.getDiscoverMovies()
                }
            }
            .store(in: &cancellableSet)
    }
    
    func setup() {
        getMovieGenres()
            .sink { completion in
                switch completion {
                case .finished:
                    print("@@@ Publisher is finished getMovieGenres()")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] genres in
                self?.genres = genres
            }
            .store(in: &cancellableSet)
        
        getDiscoverMovies()
    }
    
    func loadMoreContent(movie: Movie) {
        switch currentSearchType {
        case .titleSearch:
            let thresholdIndex = self.searchedMovies.last?.id
            if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
                currentPage += 1
                getSearchedMovies(title: searchTitle, page: currentPage)
            }
        case .filterSearch:
            let thresholdIndex = self.searchedMovies.last?.id
            if thresholdIndex == movie.id, (currentPage + 1) <= totalPages {
                currentPage += 1
                getDiscoverMovies()
            }
        }
    }

    func getSearchedMovies(title query: String, page: Int) {
        fetchSearchedMovies(title: query, page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    print("@@@ Publisher is finished getSearchedMovies()")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] success in
                guard let self = self else { return }
                if success.results.count != 0 {
                    self.isNotFound = false
                    self.adaptMovie(findedMovies: success.results)
                } else {
                    self.searchedMovies.removeAll()
                    self.isNotFound = true
                }
                self.totalPages = success.totalPages
                self.isReset = false
            }
            .store(in: &cancellableSet)

    }
    
    private func fetchSearchedMovies(title query: String, page: Int) -> AnyPublisher<GetFindedMoviesResponse, Error> {
        Future { handler in
            if !query.isEmpty {
                self.isLoading = true
                self.searchService.getSearchedMovies(query: query, page: page) { [weak self] result in
                    guard let self = self else { return }
                    switch result {
                    case .success(let success):
                        handler(.success(success))
                    case .failure(let failure):
                        handler(.failure(failure))
                    }
                    self.isLoading = false
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getDiscoverMovies() {
        fetchDiscoverMovies()
            .sink { completion in
                switch completion {
                case .finished:
                    print("@@@ Publisher is finished getDiscoverMovies()")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] success in
                guard let self = self else { return }
                if success.results.count != 0 {
                    self.isNotFound = false
                    self.adaptMovie(findedMovies: success.results)
                } else {
                    self.isNotFound = true
                }
                self.totalPages = success.totalPages
                self.isReset = false
            }
            .store(in: &cancellableSet)
    }
    
    private func fetchDiscoverMovies() -> AnyPublisher<GetFindedMoviesResponse, Error> {
        isLoading = true
        buildDiscoverParams()
        print("----------------------------------------------")
        for (key, value) in requestParameters {
            print("\(key) : \(value)")
        }
        print("----------------------------------------------")
        return Future { handler in
            self.discoverService.getDiscoverMovies(params: self.requestParameters) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let success):
                    handler(.success(success))
                case .failure(let failure):
                    handler(.failure(failure))
                }
                self.isLoading = false
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func adaptMovie(findedMovies: [FindedMovie]) {
        var _posterPath = ""
        var _backdropPath = ""
        var _searchedMovies: [Movie] = []
        
        findedMovies.forEach { findedMovie in
            if let poster = findedMovie.posterPath {
                _posterPath = poster
            }
            
            if let backdrop = findedMovie.backdropPath {
                _backdropPath = backdrop
            }
            
            let movie = Movie(
                posterPath: _posterPath,
                backdropPath: _backdropPath,
                genreIds: findedMovie.genreIds,
                originalTitle: findedMovie.originalTitle,
                title: findedMovie.title,
                voteAverage: findedMovie.voteAverage,
                id: findedMovie.id
            )
            _searchedMovies.append(movie)
        }
        
        if currentPage == 1 {
            searchedMovies = _searchedMovies
        } else {
            searchedMovies.append(contentsOf: _searchedMovies)
        }
    }
    
    private func buildDiscoverParams() {
        requestParameters["page"] = currentPage
        requestParameters["year"] = Int(year)
    
        let stringOfGenrees = withGenres.joined(separator: ",")
        requestParameters["with_genres"] = stringOfGenrees
        
        switch sortBy {
        case .popularity:
            requestParameters["sort_by"] = "popularity.desc"
        case .lastRelease:
            requestParameters["sort_by"] = "release_date.desc"
        case .empty:
            requestParameters["sort_by"] = "popularity.desc"
        }
    }
    
    func getMovieGenres() -> AnyPublisher<[Genre], Error> {
        Future { handler in
            self.genreService.getGenreList { result in
                switch result {
                case .success(let success):
                    handler(.success(success.genres))
                case .failure(let failure):
                    handler(.failure(failure))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func clearParams() {
        requestParameters = [
            "api_key": ServerConstants.apiKey,
            "language": "en-US"
        ]
        
        currentSearchType = .filterSearch
        category = .empty
        year = ""
        withGenres.removeAll()
        sortBy = .empty
        currentPage = 1
        scrollToTopOnChange.toggle()
        isReset = true
        
        selectedFilters.removeAll()
        searchedMovies.removeAll()
    }
    
    func clearSearchField() {
        searchTitle = ""
        currentSearchType = .filterSearch
        currentPage = 1
        isNotFound = false
        isFocused = false
        scrollToTopOnChange.toggle()
        searchedMovies.removeAll()
    }
    
    private func searchTitleIsValid(title: String) -> String? {
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
