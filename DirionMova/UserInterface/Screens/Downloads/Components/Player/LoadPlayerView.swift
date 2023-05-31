//
//  LoadPlayerView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 16.01.2023.
//

import SwiftUI
import AVFoundation
import AVKit

struct LoadPlayerView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @EnvironmentObject var downloadManager: DownloadManager
    @State private var player = AVPlayer()
    let name: String
    let originalTitle: String
    
    var body: some View {
        VStack {
            Spacer()
            VideoPlayer(player: player)
                .onAppear {
                    let playerItem = downloadManager.getVideoFileAsset(name: name)
                    if let playerItem = playerItem {
                        player = AVPlayer(playerItem: playerItem)
                    }
                    player.play()
                }
                .overlay(
                    HStack {
                        VStack {
                            HStack {
                                Button(action: {
                                    coordinator.pop()
                                }) {
                                    Image("arrowLeftLighWhite")
                                        .frame(width: 28, height: 28)
                                }
                                .padding(.leading, 24)
                                
                                Text(originalTitle)
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                        }
                        Spacer()
                    }
                )
                .rotationEffect(.degrees(90))
                .frame(width: UIScreen.main.bounds.height, height: UIScreen.main.bounds.width)
            Spacer()
        }
        .ignoresSafeArea()
    }
}

struct LoadPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        LoadPlayerView(name: "name", originalTitle: "Text")
    }
}
