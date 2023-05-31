//
//  HomeViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 12.10.2022.
//

import SwiftUI
import Foundation

//MARK: - HomeViewModelProtocol
protocol HomeViewModelProtocol {
    
}

class HomeViewModel: ObservableObject {
    //MARK: - Binding Properties
    @Published var nowPlayingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var upcomingMovies: [Movie] = []
    @Published var isGoToDetails: Bool = false
    //MARK: - Private Properties
    private let moviesDataFetchService = MoviesDataFetchService()
    
    //MARK: - Public Methods
    func getNowPlayingMovieData() {
        moviesDataFetchService.getNowPlayingMovies { result in
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(GetPopularMoviesResponse.self, from: data.data)
                    self.nowPlayingMovies = responseData.results
                    print("+++Success fetch and decode films from data ? - \(responseData.results)")
                } catch(let error) {
                    print("+++Error decoding response data from getNowPlayingMovieResponse response - \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getPopularMovieData() {
        moviesDataFetchService.getPopularMovies { result in
            switch result {
            case .success(let data):
                do {
                    let responseData = try JSONDecoder().decode(GetPopularMoviesResponse.self, from: data.data)
                    self.popularMovies = responseData.results
                    print("+++Success fetch and decode films from data ? - \(responseData.results)")
                } catch(let error) {
                    print("+++Error decoding response data from getPopularMoviesResponse response - \(error)")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    

    
    func getPosterImageW154URL(movie: Movie) -> String {
        print("\(ServerConstants.imagesBaseURL)/w154\(movie.posterPath)")
        return "\(ServerConstants.imagesBaseURL)/w154\(movie.posterPath)"
    }
}
