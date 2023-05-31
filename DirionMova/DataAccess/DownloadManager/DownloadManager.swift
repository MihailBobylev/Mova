//
//  DownloadManager2.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 26.01.2023.
//

import Foundation
import AVFoundation
import UIKit

class DownloadManager: NSObject, ObservableObject, URLSessionDelegate {
    @Published var progress: Double = 0
    @Published var countOfBytesReceived: Int64 = 0
    @Published var countOfBytesExpectedToReceive: Int64 = 0
    @Published var reloadDownloadScreenToggle = false
    @Published var reloadDetailsScreenToggle = false
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.background(withIdentifier: "downloadSession")
        configuration.isDiscretionary = true
        configuration.sessionSendsLaunchEvents = true
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    private(set) var operations = [Int: DownloadOperation]()
    private var operationsFileName = [Int: String]()
    
    let total: Double = 1
    let notificationManager = NotificationsManager()
    let docsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    let directoryPath = "mova-downloads"
    let postersPath = "posters"
    let moviesPath = "movies"
    private let titlesPath = "titles"
    //private let url = URL(string: "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1772_fB-zSxQ1lzuau0EmqwFLhVcv9td_")
    private let url = URL(string: "https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1_RJJiXW9Sx7mipvUV8I9tGKLzqYARxhB")
    
    private let queue: OperationQueue = {
        let _queue = OperationQueue()
        _queue.name = "download"
        _queue.maxConcurrentOperationCount = 1
        
        return _queue
    }()
    
    private func queueDownload(_ url: URL, fileName: String, originalTitle: String, isMovie: Bool) -> DownloadOperation {
        let operation = DownloadOperation(session: session, url: url, fileName: fileName, originalTitle: originalTitle, downloadManager: self, isMovie: isMovie)
        operations[operation.task.taskIdentifier] = operation
        operationsFileName[operation.task.taskIdentifier] = fileName
        return operation
    }
    
    func downloadMovie(movie: MovieDetailsResponse?) {
        guard let movaDownloadsUrl = docsUrl?.appendingPathComponent(directoryPath) else {
            return
        }
        let movaPostersUrl = movaDownloadsUrl.appendingPathComponent(postersPath)
        let movaMoviesUrl = movaDownloadsUrl.appendingPathComponent(moviesPath)
        
        var isDirectory: ObjCBool = true
        let exists = FileManager().fileExists(atPath: movaDownloadsUrl.path, isDirectory: &isDirectory)
        
        if (!exists || !isDirectory.boolValue) {
            do {
                try FileManager.default.createDirectory(at: movaPostersUrl, withIntermediateDirectories: true)
                try FileManager.default.createDirectory(at: movaMoviesUrl, withIntermediateDirectories: true)
            }
            catch {
                print(error)
                return
            }
        }
        
        guard let posterPath = movie?.getPosterPathURL, let imageName = movie?.posterPath, let originalTitle = movie?.originalTitle else {
            return
        }
        
        guard let _url = url else {
            print("URL cast error")
            return
        }
        
        writeToTitlesFile(directoryUrl: movaDownloadsUrl, title: originalTitle, imageName: imageName)
        let op1 = queueDownload(posterPath, fileName: imageName, originalTitle: originalTitle, isMovie: false)
        let op2 = queueDownload(_url, fileName: imageName, originalTitle: originalTitle, isMovie: true)
        queue.addOperation(op1)
        queue.addOperation(op2)
    }
    
    func getMovies() -> [FilmModel] {
        var movies = [FilmModel]()
        do {
            guard let movaDownloadsUrl = docsUrl?.appendingPathComponent(directoryPath) else { return [FilmModel]() }
            let titleFileUrl = movaDownloadsUrl.appendingPathComponent(titlesPath).appendingPathExtension("txt")
            let filmInfoStrings = try String(contentsOf: titleFileUrl, encoding: .utf8).components(separatedBy: "\n").filter{ !$0.isEmpty }
            var stringSize = ""
            var isDownloaded = false
            try filmInfoStrings.forEach { info in
                isDownloaded = false
                let fullInfoArray = info.components(separatedBy: "@")
                let contentUrl = movaDownloadsUrl.appendingPathComponent(moviesPath).appendingPathComponent(fullInfoArray.last ?? "").appendingPathExtension("mp4")
                var fileSize: Int64 = 0
                if checkFileExists(name: fullInfoArray.last ?? "") {
                    isDownloaded = true
                    let attr = try FileManager.default.attributesOfItem(atPath: contentUrl.path)
                    fileSize = attr[.size] as? Int64 ?? 0
                }
                let bcf = ByteCountFormatter()
                bcf.allowedUnits = [.useMB]
                bcf.countStyle = .file
                stringSize = bcf.string(fromByteCount: fileSize)
                
                movies.append(FilmModel(title: fullInfoArray.first ?? "", image: loadPoster(name: fullInfoArray.last ?? ""), imageName: fullInfoArray.last ?? "", duration: "", content: fullInfoArray.last ?? "", fileSize: String(stringSize), isDownloaded: isDownloaded))
            }
            return movies
        }
        catch {
            print(error)
            return movies
        }
    }
    
    func deleteMovie(imageName: String) {
        deleteTitle(imageName: imageName)
        deletePoster(name: imageName)
        deleteFile(name: imageName)
    }
    
    func clearMovaDownloads() {
        guard let movaDownloadsUrl = docsUrl?.appendingPathComponent(directoryPath) else {return}
        cancellAll()
        do {
            try FileManager().removeItem(atPath: movaDownloadsUrl.path)
        } catch {
            print(error)
        }
    }
    
    func cancelDownload(imageName: String) {
        var keys = operationsFileName
            .filter { (k, v) -> Bool in v == imageName }
            .map { (k, v) -> Int in k }
        keys.sort() { $0 > $1 }
        keys.forEach { key in
            operations[key]?.cancel()
            operations.removeValue(forKey: key)
            operationsFileName.removeValue(forKey: key)
        }
        deleteTitle(imageName: imageName)
        deletePoster(name: imageName)
        deleteFile(name: imageName)
    }
    
    func cancellAll() {
        if !operations.isEmpty {
            queue.cancelAllOperations()
            operationsFileName.forEach { _, fileName in
                deleteMovie(imageName: fileName)
            }
            operations.removeAll()
            operationsFileName.removeAll()
            reloadViewsStates()
        }
    }
    
    func reloadViewsStates() {
        DispatchQueue.main.async {
            self.reloadDownloadScreenToggle.toggle()
            self.reloadDetailsScreenToggle.toggle()
        }
    }
    
    func alreadyDownloaded(imageName: String) -> Bool {
        let keys = operationsFileName
            .filter { (k, v) -> Bool in v == imageName }
            .map { (k, v) -> Int in k }
        return keys.isEmpty
    }
}

// MARK: Movie files

extension DownloadManager {
    func getVideoFileAsset(name: String) -> AVPlayerItem? {
        guard let fileUrl = docsUrl?.appendingPathComponent(directoryPath).appendingPathComponent(moviesPath).appendingPathComponent(name).appendingPathExtension("mp4") else {return nil}
        if (FileManager.default.fileExists(atPath: fileUrl.path)) {
            let avAssest = AVAsset(url: fileUrl)
            return AVPlayerItem(asset: avAssest)
        } else {
            return nil
        }
    }
    
    private func checkFileExists(name: String) -> Bool {
        guard let fileUrl = docsUrl?.appendingPathComponent(directoryPath).appendingPathComponent(moviesPath).appendingPathComponent(name).appendingPathExtension("mp4") else {return false}
        return FileManager().fileExists(atPath: fileUrl.path)
    }
    
    private func deleteFile(name: String) {
        guard let fileUrl = docsUrl?.appendingPathComponent(directoryPath).appendingPathComponent(moviesPath).appendingPathComponent(name).appendingPathExtension("mp4") else {return}
        guard FileManager().fileExists(atPath: fileUrl.path) else { return }
        
        do {
            try FileManager().removeItem(atPath: fileUrl.path)
            print("Video file deleted successfully")
        } catch let error {
            print("Error while deleting video file: ", error)
        }
    }
}

// MARK: Poster files

extension DownloadManager {
    private func loadPoster(name: String) -> UIImage? {
        guard let destinationUrl = docsUrl?.appendingPathComponent(directoryPath).appendingPathComponent(postersPath).appendingPathComponent(name).appendingPathExtension("jpg") else {return nil}
        return UIImage(contentsOfFile: destinationUrl.path)
    }
    
    private func deletePoster(name: String) {
        guard let postersUrl = docsUrl?.appendingPathComponent(directoryPath).appendingPathComponent(postersPath).appendingPathComponent(name).appendingPathExtension("jpg") else {return}
        guard FileManager().fileExists(atPath: postersUrl.path) else {return}
        
        do {
            try FileManager().removeItem(atPath: postersUrl.path)
            print("Poster file deleted successfully")
        } catch let error {
            print("Error while deleting video file: ", error)
        }
    }
}

// MARK: Title file

extension DownloadManager {
    func checkTitleExists(name: String) -> Bool {
        guard let movaDownloadsUrl = docsUrl?.appendingPathComponent(directoryPath) else { return false }
        let titleFileUrl = movaDownloadsUrl.appendingPathComponent(titlesPath).appendingPathExtension("txt")
        var exist = false
        do {
            let filmInfoStrings = try String(contentsOf: titleFileUrl, encoding: .utf8).components(separatedBy: "\n").filter{ !$0.isEmpty }
            filmInfoStrings.forEach { item in
                if item.contains(name) {
                    exist = true
                    return
                }
            }
        } catch {
            print(error)
        }
        return exist
    }
    
    private func deleteTitle(imageName: String) {
        guard let titlesFileUrl = docsUrl?.appendingPathComponent(directoryPath).appendingPathComponent(titlesPath).appendingPathExtension("txt") else {return}
        do {
            if try imageName.alreadyExistsInFile(in: titlesFileUrl) {
                let filmInfoString = try String(contentsOf: titlesFileUrl, encoding: .utf8).components(separatedBy: "\n").filter{ !$0.isEmpty }
                let filteredLines = filmInfoString.filter { !$0.contains(imageName) }
                deleteTitlesFile(titlesFileUrl: titlesFileUrl)
                filteredLines.forEach { movie in
                    overwriteTitlesFile(titlesFileUrl: titlesFileUrl, movieInfo: movie)
                }
            }
        } catch {
            print(error)
        }
    }
    
    private func deleteTitlesFile(titlesFileUrl: URL) {
        guard FileManager().fileExists(atPath: titlesFileUrl.path) else {return}
        do {
            try FileManager().removeItem(atPath: titlesFileUrl.path)
            print("Titels file deleted successfully")
        } catch let error {
            print("Error while deleting titles file: ", error)
        }
    }
    
    private func writeToTitlesFile(directoryUrl: URL, title: String, imageName: String) {
        let titleFileUrl = directoryUrl.appendingPathComponent(titlesPath).appendingPathExtension("txt")
        
        do {
            let filmInfoString = title + "@" + imageName
            if try !filmInfoString.alreadyExistsInFile(in: titleFileUrl) {
                try filmInfoString.appendLine(to: titleFileUrl)
            } else {
                print("Title alreary exists in file")
            }
        } catch {
            print(error)
        }
    }
    
    private func overwriteTitlesFile(titlesFileUrl: URL, movieInfo: String) {
        do {
            try movieInfo.appendLine(to: titlesFileUrl)
        } catch {
            print(error)
        }
    }
}

// MARK: URLSessionTaskDelegate methods

extension DownloadManager: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)  {
        let key = task.taskIdentifier
        operations[key]?.urlSession(session, task: task, didCompleteWithError: error)
        operations.removeValue(forKey: key)
        operationsFileName.removeValue(forKey: key)
        DispatchQueue.main.async {
            self.reloadDownloadScreenToggle.toggle()
            self.progress = 0
            self.countOfBytesReceived = 0
            self.countOfBytesExpectedToReceive = 0
            if self.operations.isEmpty {
                self.reloadDetailsScreenToggle.toggle()
            }
        }
    }
}

// MARK: URLSessionDownloadDelegate methods

extension DownloadManager: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        guard let response = downloadTask.response as? HTTPURLResponse else {
            return
        }
        switch response.statusCode {
        case 200:
            operations[downloadTask.taskIdentifier]?.urlSession(session, downloadTask: downloadTask, didFinishDownloadingTo: location)
        case 206:
            print("206")
            break
        default:
            print("Status code for \(String(describing: session.configuration.identifier)): \(response.statusCode)")
            downloadError(taskDescription: downloadTask.taskDescription)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        operations[downloadTask.taskIdentifier]?.urlSession(session, downloadTask: downloadTask, didWriteData: bytesWritten, totalBytesWritten: totalBytesWritten, totalBytesExpectedToWrite: totalBytesExpectedToWrite)
    }
    
    func downloadError(taskDescription: String?) {
        notificationManager.sendErrorNotification()
        guard let fileName = taskDescription?.components(separatedBy: "@") else {return}
        guard let fileName = fileName.first else {return}
        print("downloadError: \(fileName)")
        cancelDownload(imageName: fileName)
    }
}
