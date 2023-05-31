//
//  Image+Extension.swift
//  DirionMova
//
//  Created by Юрий Альт on 17.10.2022.
//

import SwiftUI

extension Image {
    func data(url: URL) -> Self {
        var image = Image("")
        if let data = try? Data(contentsOf: url) {
            if let uiImageFromData = UIImage(data: data) {
                let imageFromUIImgae = Image(uiImage: uiImageFromData)
                image = imageFromUIImgae
            }
        }
        return image
            .resizable()
    }
}
