//
//  PlayerView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.11.2022.
//

import SwiftUI
import AVFoundation
import AVKit

struct PlayerView: View {
    @ObservedObject var playerViewModel: PlayerViewModel
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    coordinator.pop()
                }) {
                    Image("arrowLeftLighWhite")
                        .frame(width: 28, height: 28)
                }
                .padding(.leading, 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            YTWrapper(videoID: playerViewModel.movieTrailer.key)
        }
        .onAppear {
            playerViewModel.getMovieDetails()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(playerViewModel: PlayerViewModel(movieId: "0"))
    }
}
