//
//  ProgressPopUpViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 23.01.2023.
//

import Foundation

class ProgressPopUpViewModel: ObservableObject {
    private var downloadManager: DownloadManager?
    
    func setup(_ downloadManager: DownloadManager) {
        self.downloadManager = downloadManager
    }
    
    func cancelDownload(imageName: String?) {
        guard let _imageName = imageName else {return}
        downloadManager?.cancelDownload(imageName: _imageName)
        print("Download canceled")
    }
    
    func alreadyDownloaded(imageName: String?) -> Bool {
        guard let _imageName = imageName else {return true}
        let isDownloaded = downloadManager?.alreadyDownloaded(imageName: _imageName)
        guard let _isDownloaded = isDownloaded else {return true}
        
        return _isDownloaded
    }
}
