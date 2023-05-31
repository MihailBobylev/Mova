//
//  TrailersList.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/25/22.
//

import SwiftUI

struct TrailersList: View {
    
    @ObservedObject var viewModel: MovieDetailsViewModel
    
    var body: some View {
        if viewModel.isNotFoundTrailers {
            NotFoundScreen(showDescription: false)
                .padding( .bottom, 24.dvs)
        } else {
            LazyVStack(alignment: .leading) {
                ForEach(0..<viewModel.trailerList.count, id: \.self) { index in
                    HStack {
                        YTWrapper(videoID: viewModel.trailerList[index].key)
                            .frame(width: 150.dhs, height: 120.dvs)
                            .cornerRadius(10, corners: .allCorners)
                        Text(viewModel.trailerList[index].name ?? "")
                            .font(Font.Urbanist.Bold.size(of: 16.dfs))
                            .padding([.leading], 20.dhs)
                    }
                }
            }
            .padding( .bottom, 24.dvs)
        }
    }
}

struct TrailersList_Previews: PreviewProvider {
    static var previews: some View {
        TrailersList(viewModel: MovieDetailsViewModel(movieId: 22))
    }
}
