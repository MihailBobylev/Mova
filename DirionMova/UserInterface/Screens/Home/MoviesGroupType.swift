//
//  HomeViewColumnsData.swift
//  DirionMova
//
//  Created by Юрий Альт on 24.10.2022.
//

enum MoviesGroupType: String, CaseIterable, Identifiable {
    var id: Self { return self }
    
    case popularMovies = "Popular Movies"
    case topRatedMovies = "Top Rated Movies"
    case nowPlayingMovies = "Now Playing Movies"
    case upcomingMovies = "Upcoming Movies"
}
