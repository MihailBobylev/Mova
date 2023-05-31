//
//  MoreLikeThisList.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/27/22.
//

import SwiftUI

struct MoreLikeThisList: View {
    @ObservedObject var viewModel: MovieDetailsViewModel
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        if viewModel.isNotFoundSimilars {
            NotFoundScreen(showDescription: false)
                .padding( .bottom, 24.dvs)
        } else {
            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 8.dvs) {
                ForEach(viewModel.similarMoviesList, id: \.self) { index in
                    MovieCellView(action: {
                        coordinator.show(.movieDetails(movieId: index.id))
                    },
                                  imageURL: index.posterPath.getPosterImageURL(imageType: .poster(width: .w342)),
                                  rating: index.voteAverage.roundedStringValue)
                    .onAppear {
                        viewModel.loadMoreContent(movie: index)
                    }
                    .aspectRatio(contentMode: .fill)
                }
            }
        }
    }
}

