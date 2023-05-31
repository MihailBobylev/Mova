//
//  DownloadsViewModel.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/30/22.
//

import Foundation
import AVFoundation
import UIKit

class DownloadsViewModel: ObservableObject {
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    private var downloadManager: DownloadManager?
    lazy var isGuest = storage.isGuest
    
    @Published var isPresentSheet = false
    @Published var movies: [FilmModel] = []
    @Published var delitingMovie = FilmModel(title: "", image: UIImage(), imageName: "", duration: "" , content: "", fileSize: "", isDownloaded: false)
    @Published var connectionLost = false
    
    func setup(_ downloadManager: DownloadManager) {
        NotificationCenter.default.addObserver(self, selector: #selector(checkInternerConnection(notification:)), name: NSNotification.Name.connectivityStatus, object: nil)
        self.downloadManager = downloadManager
    }
    
    func deleteFilm(movie: FilmModel) {
        downloadManager?.deleteMovie(imageName: movie.imageName)
        delitingMovie = FilmModel(title: "", image: UIImage(), imageName: "", duration: "" , content: "", fileSize: "", isDownloaded: false)
        loadData()
    }
    
    func loadData() {
        if let _movies = downloadManager?.getMovies() {
            movies = _movies
        }
    }
    
    func loadProgress() -> Double {
        if let _progress = downloadManager?.progress {
            return _progress
        } else {
            return 0
        }
    }
    
    @objc func checkInternerConnection(notification: Notification) {
        DispatchQueue.main.async {
            self.connectionLost = !NetworkMonitor.shared.isConnected
        }
    }
}
