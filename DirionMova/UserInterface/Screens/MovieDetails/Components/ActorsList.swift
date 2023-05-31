//
//  ActorsList.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/20/22.
//

import SwiftUI
import Kingfisher

struct ActorsList: View {
    let actors: [ActorsModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20.dhs) {
                Spacer().frame(width: 4.dhs, height: 1.dvs)
                ForEach(0..<actors.count, id: \.self) { index in
                    ActorView(cast: actors[index])
                }
                Spacer().frame(width: 4.dhs, height: 1.dvs)
            }
        }
    }
}

struct ActorsList_Previews: PreviewProvider {
    static var previews: some View {
        ActorsList(actors: [ActorsModel(name: "fff", job: "fff", picturePath: "ff")])
    }
}

struct ActorView: View {
    
    let cast: ActorsModel
    var body: some View {
        HStack(spacing: 12.dhs) {
            actorImage
            VStack(spacing: 4.dvs) {
                actorName
                roleText
            }
        }
    }
}

extension ActorView {
    
    var actorImage: some View {
        KFImage(URL(string: cast.picturePath.getPosterImageURL(imageType: .poster(width: .w92))))
            .placeholder {
                Image("defaultActorImage")
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                    .aspectRatio(contentMode: .fill)
            }
            .resizable()
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .frame(width: 40, height: 40)
    }
    
    var actorName: some View {
        Text(cast.name)
            .foregroundColor(.MovieDetails.castNameText)
            .frame(width: 50.dhs, alignment: .leading)
            .font(Font.Urbanist.SemiBold.size(of: 10.dfs))
            .lineLimit(3)
    }
    
    var roleText: some View {
        Text(cast.job)
            .foregroundColor(.MovieDetails.castRoleText)
            .frame(width: 50.dhs, alignment: .leading)
            .font(Font.Urbanist.Regular.size(of: 10.dfs))
    }
}
