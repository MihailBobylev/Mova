//
//  VideoPlayer.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 22.11.2022.
//
import SwiftUI
import AVKit

//struct VideoPlayer: UIViewControllerRepresentable {
//    var player: AVPlayer
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<VideoPlayer>) -> AVPlayerViewController {
//        let controller = AVPlayerViewController()
//        controller.player = player
//        controller.showsPlaybackControls = false
//        controller.videoGravity = .resize
//        return controller
//    }
//
//    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: UIViewControllerRepresentableContext<VideoPlayer>) {
//        print("Update")
//
//    }
//}

//enum PlayerGravity {
//    case aspectFill
//    case resize
//}
//
//class PlayerView2: UIView {
//
//    var player: AVPlayer? {
//        get {
//            return playerLayer.player
//        }
//        set {
//            playerLayer.player = newValue
//        }
//    }
//
//    let gravity: PlayerGravity
//
//    init(player: AVPlayer, gravity: PlayerGravity) {
//        self.gravity = gravity
//        super.init(frame: .zero)
//        self.player = player
//        self.backgroundColor = .black
//        setupLayer()
//    }
//
//    func setupLayer() {
//        switch gravity {
//
//        case .aspectFill:
//            playerLayer.contentsGravity = .resizeAspectFill
//            playerLayer.videoGravity = .resizeAspectFill
//
//        case .resize:
//            playerLayer.contentsGravity = .resize
//            playerLayer.videoGravity = .resize
//
//        }
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    var playerLayer: AVPlayerLayer {
//        return layer as! AVPlayerLayer
//    }
//
//    // Override UIView property
//    override static var layerClass: AnyClass {
//        return AVPlayerLayer.self
//    }
//}
//
////- SwiftUI Representable
//
//final class PlayerContainerView: UIViewRepresentable {
//
//    typealias UIViewType = PlayerView2
//
//    let player: AVPlayer
//    let gravity: PlayerGravity
//
//    init(player: AVPlayer, gravity: PlayerGravity) {
//        self.player = player
//        self.gravity = gravity
//    }
//
//    func makeUIView(context: Context) -> PlayerView2 {
//        return PlayerView2(player: player, gravity: gravity)
//    }
//
//    func updateUIView(_ uiView: PlayerView2, context: Context) { }
//}
//
//class PlayerViewModel2: ObservableObject {
//    @EnvironmentObject var downloadManager: DownloadManager
//    let player: AVPlayer
//
//    init(player: AVPlayer) {
//
//        self.player = player
//        self.play()
//    }
//
//    func play() {
//        let currentItem = player.currentItem
//        if currentItem?.currentTime() == currentItem?.duration {
//            currentItem?.seek(to: .zero, completionHandler: nil)
//        }
//
//        player.play()
//    }
//
//    func pause() {
//        player.pause()
//    }
//
//}
