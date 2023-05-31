//
//  Data+Extension.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.01.2023.
//

import Foundation

extension Data {
    func append(to url: URL) throws {
        if let fileHandle = try? FileHandle(forWritingTo: url) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        } else {
            try write(to: url)
        }
    }
    
    func existsInFile(in url: URL, title: String) throws -> Bool {
        if let fileHandle = try? FileHandle(forReadingFrom: url) {
            defer {
                fileHandle.closeFile()
            }
            if let data = try? fileHandle.readToEnd() {
                if let str = String(data: data, encoding: .utf8) {
                    return str.contains(title)
                }
            }
        }
        return false
    }
}
