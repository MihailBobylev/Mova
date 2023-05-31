//
//  MovieVideoDetailsButton.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/27/22.
//

import SwiftUI

struct MovieVideoDetailsButton: View {
    private let buttonTitles = ["Trailers", "More Like This"]
    @Binding var currentIndex: Int
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<buttonTitles.count, id: \.self) { index in
                Button(action: {
                    currentIndex = index
                }, label: {
                    ZStack {
                        Color(Color.MovieDetails.background)
                        VStack {
                            Text(buttonTitles[index])
                                .foregroundColor(index == currentIndex ? Color(UIColor.MOVA.primary500) : Color(UIColor.MOVA.Greyscale500Greyscale700))
                                .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                                .lineLimit(1)
                            VStack {
                                Capsule()
                                    .frame(height: index == currentIndex ? 4 : 2)
                                    .foregroundColor(index == currentIndex ? Color(UIColor.MOVA.primary500) : Color(UIColor.MOVA.Greyscale200Dark3))
                                    .padding(.bottom, index == currentIndex  ? 0 : 2)
                            }
                            .frame(height: 4.dvs)
                        }
                        .padding(.bottom, 8.dvs)
                    }
                })
                .tag(index)
            }
        }
    }
}

struct MovieVideoDetailsButton_Previews: PreviewProvider {
    static var previews: some View {
        MovieVideoDetailsButton(currentIndex: .constant(0))
    }
}

