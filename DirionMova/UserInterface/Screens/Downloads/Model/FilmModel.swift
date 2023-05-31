//
//  FilmModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 16.01.2023.
//

import Foundation
import UIKit

struct FilmModel: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let image: UIImage?
    let imageName: String
    let duration: String
    let content: String
    let fileSize: String
    let isDownloaded: Bool
}
