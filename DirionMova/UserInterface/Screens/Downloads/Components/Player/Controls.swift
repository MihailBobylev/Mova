//
//  Controls.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 22.11.2022.
//

import SwiftUI
import AVFoundation

struct Controls: View {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var pannel: Bool
    @Binding var value: Float
    let originalTitle: String
    @State var tmp: Float = 0.0
    
    let gradientTop = Gradient(colors: [.clear, .clear, .clear, .black])
    let gradientBottom = Gradient(colors: [.clear, .clear, .black])
    let backAction: () -> ()
    
    var body: some View {
        VStack {
            HStack {
                HStack {
                    Button(action: {
                        backAction()
                    }) {
                        Image("arrowLeftLighWhite")
                            .frame(width: 28, height: 28)
                    }
                    .padding(.leading, 24)

                    Text(originalTitle)
                        .font(.Urbanist.Regular.size(of: 20))
                        .foregroundColor(.white)
                }
                Spacer()
                TopControlsMenuView()
            }
            
            Spacer()
            
            if let _duration = player.currentItem?.duration.seconds {
                if !_duration.isNaN {
                    Slider(value: $value, in: 0...Float(_duration)) { isEditing in
                        player.seek(to: CMTime(seconds: Double(value), preferredTimescale: 1))
                    }
                }
            }
            
            BottomControlsMenuView(player: $player, isPlaying: $isPlaying, pannel: $pannel, value: $value, tmp: $tmp)
        }
        .padding()
        .background(
            VStack {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: gradientTop, startPoint: .bottom, endPoint: .top)
                    )
                Rectangle()
                    .fill(
                        LinearGradient(gradient: gradientBottom, startPoint: .top, endPoint: .bottom)
                    )
            }
        )
        .onTapGesture {
            pannel = false
        }
        .onAppear {
            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: .main) { _ in
                
                value = Float(player.currentTime().seconds)
                print("+++value: \(value)")
                if value == 1.0 {
                    isPlaying = false
                }
            }
        }
    }
}

struct Controls_Previews: PreviewProvider {
    static var previews: some View {
        Controls(player: .constant(AVPlayer(url: URL(string: "https://bit.ly/swswift")!)), isPlaying: .constant(false), pannel: .constant(true), value: .constant(30.0), originalTitle: "Title"){}
    }
}

struct TopControlsMenuView: View {
    var body: some View {
        HStack {
            Button {
                
            } label: {
                Image("playbackSpeedIcon")
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
            }
            
            Button {
                
            } label: {
                Image("timerIcon")
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
            }
            Button {
                
            } label: {
                Image("subtitlesIcon")
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
            }
            
            Button {
                
            } label: {
                Image("microphoneIcon")
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
            }
            Button {
                
            } label: {
                Image("pipIcon")
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
            }
            
            Button {
                
            } label: {
                Image("settingsIcon")
                    .font(.title)
                    .padding(20)
                    .foregroundColor(.white)
            }
        }
    }
}

struct BottomControlsMenuView: View {
    @Binding var player: AVPlayer
    @Binding var isPlaying: Bool
    @Binding var pannel: Bool
    @Binding var value: Float
    @Binding var tmp: Float
    
    var body: some View {
        HStack {
            HStack {
                Button {
                    
                } label: {
                    Image("lockIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
                
                Button {
                    
                } label: {
                    Image("volumeIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    player.seek(to: CMTime(seconds: Double(value) - 10, preferredTimescale: 1))
                } label: {
                    Image("backwardIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
                
                Button {
                    player.seek(to: CMTime(seconds: 0.0, preferredTimescale: 1))
                } label: {
                    Image("toStartIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
                
                Button {
                    if isPlaying {
                        player.pause()
                        isPlaying = false
                    } else {
                        player.play()
                        isPlaying = true
                    }
                } label: {
                    Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
                
                Button {
                    if let _duration = player.currentItem?.duration.seconds {
                        player.seek(to: CMTime(seconds: _duration, preferredTimescale: 1))
                    }
                } label: {
                    Image("toEndIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
                
                Button {
                    player.seek(to: CMTime(seconds: Double(value) + 10, preferredTimescale: 1))
                } label: {
                    Image("forwardIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            HStack {
                Button {
                    
                } label: {
                    Image("downloadIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
                
                Button {
                    
                } label: {
                    Image("minimizeIcon")
                        .font(.title)
                        .padding(20)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
