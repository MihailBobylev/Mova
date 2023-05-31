//
//  InterestScreen.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 18.10.2022.
//

import SwiftUI

struct InterestScreen: View {
    @StateObject private var interestViewModel = InterestViewModel()
    @State private var interests = [
        "Action", "Drama", "Comedy", "Horror", "Adventure",
        "Thriller", "Romance", "Science", "Animation", "Documentary",
        "Crime", "Fantasy", "Mystery", "Ficton", "War",
        "History", "Television", "Superheroes","Anime",
        "Sports", "K-Drama"
    ]
    
    @State private var selectedInterests: [String] = []
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Choose your interests and get the best movie recommendations. Don't worry, you can always change it later.")
                .font(Font.Urbanist.Medium.size(of: 18))
                .padding([.leading, .trailing, .bottom], 24.dhs)
                .padding(.top, 36.dvs)
            GeometryReader { geometry in
                ScrollView(showsIndicators: false) {
                    generateContent(in: geometry)
                }
                .padding(.leading,  24.dhs)
            }
            HStack {
                Button("Skip") {
                    selectedInterests.removeAll()
                    coordinator.show(.profile)
                }
                .buttonStyle(GrayButton())
                .padding(.leading, 24.dhs)
                .padding(.trailing, 12.dhs)
                
                Button("Continue") {
                    print(selectedInterests)
                    coordinator.show(.profile)
                }
                .buttonStyle(MovaButton())
                .padding(.trailing, 24.dhs)
            }
            .frame(height: 58.dvs)
            .padding([.top, .bottom], 28.dvs)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Choose Your Interest")
                        .font(Font.Urbanist.Bold.size(of: 24))
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
            }
        }
    }
    
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(interests, id: \.self) { interest in
                InterestElement(selectedInterests: $selectedInterests, text: interest)
                    .padding(.horizontal, 6.dhs)
                    .padding(.vertical, 12.dhs)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width-24) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if interest == interests.last {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if interest == interests.last {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
}

struct InterestScreen_Previews: PreviewProvider {
    static var previews: some View {
        InterestScreen()
    }
}
