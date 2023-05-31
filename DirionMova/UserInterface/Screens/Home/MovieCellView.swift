//
//  MovieCellView.swift
//  DirionMova
//
//  Created by Юрий Альт on 16.10.2022.
//

import SwiftUI

struct MovieCellView: View {
    //MARK: - Public Properties
    let action: () -> ()
    let imageURL: String
    let rating: String
    
    //MARK: - Body
    var body: some View {
        Button(action: action) {
            ZStack {
                Image("")
                    .data(url: URL(string: imageURL)!)
                    .cornerRadius(12)
                HStack {
                    VStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 32.0, height: 24)
                                .foregroundColor(.Home.MovieRowItem.ratingBackground)
                            Text(rating)
                                .font(.Urbanist.SemiBold.size(of: 10))
                                .foregroundColor(.Home.MovieRowItem.ratingText)
                        }
                        Spacer()
                    }
                    .padding([.top, .leading], 12)
                    Spacer()
                }
            }
            .frame(width: 150, height: 200)
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(action: {}, imageURL: "https://s00.yaplakal.com/pics/pics_original/1/5/6/16275651.jpg", rating: "9.7")
    }
}




