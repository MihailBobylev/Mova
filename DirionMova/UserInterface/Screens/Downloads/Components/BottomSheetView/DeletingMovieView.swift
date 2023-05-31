//
//  DelitingMoveView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 19.01.2023.
//

import SwiftUI

struct DeletingMovieView: View {
    let movie: FilmModel
    
    var body: some View {
        HStack(spacing: 20.dhs) {
            makeImageView(image: movie.image)
                .frame(width: 150.dhs, height: 112.5.dvs)
                .clipped()
                .cornerRadius(10)
                .overlay(
                    Image("play")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24.dhs, height: 24.dvs)
                )
            
            VStack(alignment: .leading, spacing: 12.dvs) {
                Text(movie.title)
                    .font(.Urbanist.Bold.size(of: 18))
                    .foregroundColor(.Downloads.filmNameText)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text("1h 42m 32s")
                    .font(.Urbanist.SemiBold.size(of: 14))
                    .foregroundColor(.Downloads.durationText)
                
                HStack {
                    Text(movie.fileSize)
                        .font(.Urbanist.SemiBold.size(of: 10))
                        .foregroundColor(.Downloads.fileSizeText)
                    Spacer()
                }
            }
        }
    }
    
    @ViewBuilder private func makeImageView(image: UIImage?) -> some View {
        if let _image = image {
            Image(uiImage: _image)
                .resizable()
                .aspectRatio(contentMode: .fill)
        } else {
            Image("imagePlaceholder")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
    }
}
