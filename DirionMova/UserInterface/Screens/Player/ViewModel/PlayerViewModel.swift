//
//  PlayerViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.11.2022.
//

import SwiftUI

class PlayerViewModel: ObservableObject {
    @Published var movieID: String
    @Published var movieTrailer: MovieVideoResult = MovieVideoResult(name: nil, key: nil, site: nil)
    
    private let movieApi = MoviesDataFetchService()
    private let queue = DispatchQueue(label: "movie.detail")
    
    init(movieId: String) {
        self.movieID = movieId
    }
    func requestData() {
        queue.async {
            self.getMovieDetails()
        }
    }
    func getMovieDetails() {
        print(movieID)
        movieApi.getMovieDetails(movieID: movieID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let trailers = data.videos?.results {
                    self.movieTrailer = trailers[0]
                }
            case .failure(let error):
                debugPrint("--- PlayerViewModel --- getMovieDetails failure with error: ", error)
            }
        }
    }
}
