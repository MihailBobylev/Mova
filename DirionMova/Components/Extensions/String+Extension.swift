//
//  String+Extension.swift
//  DirionMova
//
//  Created by ~Akhtamov on 11/30/22.
//
import Foundation

extension String {
    var getYearString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateFromNetwork = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "yyyy"
        let string = dateFormatter.string(from: dateFromNetwork)
        return string
    }
    
    var getMMddyyyyString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateFromNetwork = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let string = dateFormatter.string(from: dateFromNetwork)
        return string
    }
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

extension String {
    func appendLine(to url: URL) throws {
        try self.appending("\n").append(to: url)
    }
    
    func append(to url: URL) throws {
        let data = self.data(using: .utf8)
        try data?.append(to: url)
    }
    
    func alreadyExistsInFile(in url: URL) throws -> Bool {
        let data = self.data(using: .utf8)
        if let result = try? data?.existsInFile(in: url, title: self) {
            return result
        }
        return false
    }
}
