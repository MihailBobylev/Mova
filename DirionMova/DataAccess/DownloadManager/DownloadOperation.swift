//
//  DownloadOperation.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 31.01.2023.
//

import Foundation

class DownloadOperation: AsynchronousOperation {
    let task: URLSessionTask
    let isMovie: Bool
    
    private let downloadManager: DownloadManager
    
    init(session: URLSession, url: URL, fileName: String, originalTitle: String, downloadManager: DownloadManager, isMovie: Bool) {
        task = session.downloadTask(with: url)
        if isMovie {
            task.taskDescription = fileName + "@" + originalTitle
            print("It's movie: \(task.taskIdentifier) - \(String(describing: task.taskDescription))")
        } else {
            task.taskDescription = fileName
            print("It's poster: \(task.taskIdentifier) - \(String(describing: task.taskDescription))")
        }
        self.isMovie = isMovie
        self.downloadManager = downloadManager
        super.init()
    }
    
    override func cancel() {
        super.cancel()
        
        if isExecuting {
            task.cancel()
            finish()
        }
        print("Task canceled: \(task.taskIdentifier) - \(String(describing: task.taskDescription))")
    }
    
    override func main() {
        task.resume()
        print("Task started: \(task.taskIdentifier) - \(String(describing: task.taskDescription))")
    }
}

// MARK: NSURLSessionDownloadDelegate methods

extension DownloadOperation: URLSessionDownloadDelegate {
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        do {
            if isMovie {
                guard let moviesUrl = downloadManager.docsUrl?.appendingPathComponent(downloadManager.directoryPath).appendingPathComponent(downloadManager.moviesPath) else {return}
                guard let fileNameWithTitle = downloadTask.taskDescription else {return}
                let fullInfoArray = fileNameWithTitle.components(separatedBy: "@")
                guard let fileName = fullInfoArray.first else {return}
                guard let originalTitle = fullInfoArray.last else {return}
                let savedURL = moviesUrl.appendingPathComponent(fileName).appendingPathExtension("mp4")
                try? FileManager.default.removeItem(at: savedURL)
                try FileManager.default.moveItem(at: location, to: savedURL)
                downloadManager.notificationManager.sendSuccessNotification(filmTitle: originalTitle)
                print("Movie downloaded success")
            } else {
                guard let postersUrl = downloadManager.docsUrl?.appendingPathComponent(downloadManager.directoryPath).appendingPathComponent(downloadManager.postersPath) else {return}
                guard let fileName = downloadTask.taskDescription else {return}
                let savedURL = postersUrl.appendingPathComponent(fileName).appendingPathExtension("jpg")
                try? FileManager.default.removeItem(at: savedURL)
                try FileManager.default.moveItem(at: location, to: savedURL)
                print("Poster downloaded success")
            }
        } catch {
            print ("file error: \(error)")
            downloadManager.downloadError(taskDescription: downloadTask.taskDescription)
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.downloadManager.progress = downloadTask.progress.fractionCompleted
            self.downloadManager.countOfBytesReceived = totalBytesWritten
            if self.downloadManager.countOfBytesExpectedToReceive == 0 {
                self.downloadManager.countOfBytesExpectedToReceive = totalBytesExpectedToWrite
            }
        }
    }
}

// MARK: URLSessionTaskDelegate methods

extension DownloadOperation: URLSessionTaskDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)  {
        defer {
            print("finish: \(task.taskIdentifier) - \(String(describing: task.taskDescription))")
            finish()
        }
        if let error = error {
            print(error)
            downloadManager.downloadError(taskDescription: task.taskDescription)
            return
        }
    }
    
}
