//
//  MovieCellView.swift
//  DirionMova
//
//  Created by Юрий Альт on 16.10.2022.
//

import SwiftUI
import Kingfisher

struct MovieCellView: View {
    
    //MARK: - Public Properties
    let action: () -> ()
    var removeListAction: (() -> ())? = nil
    var addListAction: (() -> ())? = nil
    let imageURL: String
    let rating: String
    var width: CGFloat = 186.dhs
    var height: CGFloat = 248.dvs
    @State var isLiked: Bool? = nil
    
    //MARK: - Body
    var body: some View {
        Button(action: action) {
            ZStack {
                KFImage(URL(string: imageURL))
                    .placeholder {
                        Color(UIColor.MOVA.greyscale300)
                            .frame(width: width, height: height)
                            .shimmer()
                            .cornerRadius(12)
                    }
                    .resizable()
                    .cornerRadius(12)
                VStack {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .frame(width: 32, height: 24)
                                .foregroundColor(.Home.MovieRowItem.ratingBackground)
                            Text(rating)
                                .font(.Urbanist.SemiBold.size(of: 10))
                                .foregroundColor(.Home.MovieRowItem.ratingText)
                        }
                        Spacer()
                        if let liked = isLiked {
                            Button(action: {
                                isLiked?.toggle()
                               likeAction(state: isLiked ?? true)
                            }) {
                                Image(liked ? "ic_like_active" : "ic_like")
                                    .frame(width: 32, height: 24)
                            }
                        }
                    }
                    Spacer()
                }
                .padding([.top, .leading, .trailing], 12)
            }
        }
        .frame(width: width, height: height)
    }
}

extension MovieCellView {
    private func likeAction(state: Bool) {
        if state {
            addListAction?()
        } else {
            removeListAction?()
        }
    }
}

struct MovieCellView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCellView(action: {}, imageURL: "https://s00.yaplakal.com/pics/pics_original/1/5/6/16275651.jpg", rating: "9.7", width: 186, height: 248)
    }
}
