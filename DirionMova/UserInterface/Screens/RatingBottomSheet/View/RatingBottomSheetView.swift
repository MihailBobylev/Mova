//
//  RatingBottomSheetView.swift
//  DirionMova
//
//  Created by Юрий Альт on 07.11.2022.
//

import SwiftUI

struct RatingBottomSheetView: View {
    @StateObject private var ratingBottomSheetViewModel = RatingBottomSheetViewModel()
    @Binding var isPresented: Bool
    let voteAvarage: Double
    let voteCount: Int
    let movieId: Int
    let isGuest: Bool
    
    //MARK: - Root View
    var body: some View {
        ZStack {
            RatingBottomSheetBackground()
            VStack(spacing: 24.dvs) {
                RatingBottomSheetHandle()
                RatingBottomSheetTitle()
                HDeviderView()
                if isGuest {
                    Text("You are currently in guest mode. Registered users can rate\n ")
                        .font(.Urbanist.SemiBold.size(of: 18.dfs))
                        .foregroundColor(.RatingBottomSheet.titleText)
                        .multilineTextAlignment(.center)
                } else {
                    VoteAvarageView(ratingBottomSheetViewModel: ratingBottomSheetViewModel, voteAvarage: voteAvarage, voteCount: voteCount)
                }
                HDeviderView()
                if !isGuest {
                    UserRatingStars(ratingBottomSheetViewModel: ratingBottomSheetViewModel)
                }
                RatingBottomButtonsView(ratingBottomSheetViewModel: ratingBottomSheetViewModel, isPresented: $isPresented, movieId: movieId, isGuest: isGuest)
                Spacer()
            }
            .padding([.leading, .trailing], 24.dhs)
            .onAppear {
                ratingBottomSheetViewModel.getAccountStates(movieId: movieId)
            }
        }
        .frame(height: isGuest ? 350.dvs : 400.dvs)
    }
}

struct RatingBottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        RatingBottomSheetView(isPresented: .constant(true), voteAvarage: 9.2, voteCount: 999999, movieId: 446, isGuest: false)
    }
}

//MARK: - Subviews
struct UserRatingStars: View {
    @ObservedObject var ratingBottomSheetViewModel: RatingBottomSheetViewModel
    
    var body: some View {
        HStack(spacing: 10.dhs) {
            ForEach(1...10, id: \.self) { element in
                Button(action: {
                    if ratingBottomSheetViewModel.rateValue == element {
                        ratingBottomSheetViewModel.rateValue = 0
                    } else {
                        ratingBottomSheetViewModel.rateValue = element
                    }
                }) {
                    ZStack {
                        Image(ratingBottomSheetViewModel.rateValue >= element ? "filledBoldStarRed" : "boldStarWhite")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("\(element)")
                            .font(.Urbanist.Bold.size(of: 8.dfs))
                            .foregroundColor(
                                ratingBottomSheetViewModel.rateValue >= element ?
                                    .RatingBottomSheet.ratingFilledStarText :
                                        .RatingBottomSheet.ratingEmptyStarText
                            )
                            .offset(x: -0.5, y: 1)
                    }
                }
            }
        }
    }
}

struct VoteAvarageView: View {
    @ObservedObject var ratingBottomSheetViewModel: RatingBottomSheetViewModel
    let voteAvarage: Double
    let voteCount: Int
    
    var body: some View {
        HStack(spacing: 24.dhs) {
            VStack(spacing: 10.dvs) {
                HStack(spacing: 4.dhs) {
                    VStack {
                        Text(voteAvarage.roundedStringValue)
                            .font(.Urbanist.Bold.size(of: 48.dfs))
                            .foregroundColor(.RatingBottomSheet.currentValueText)
                    }
                    VStack {
                        Spacer()
                        Text("/10")
                            .font(.Urbanist.Bold.size(of: 20.dfs))
                            .foregroundColor(.RatingBottomSheet.totalValueText)
                    }
                }
                .frame(height: 48.dvs)
                HStack(spacing: 6.dhs) {
                    ForEach(1...10, id: \.self) { element in
                        Image(ratingBottomSheetViewModel.getImageNameForRatingStar(star: element, voteAverage: voteAvarage))
                            .resizable()
                            .frame(width: 10, height: 9.5)
                    }
                }
                Text("(\(voteCount) users)")
                    .font(.Urbanist.Medium.size(of: 12.dfs))
                    .foregroundColor(.RatingBottomSheet.votesCountText)
            }
        }
    }
}

struct RatingBottomButtonsView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @ObservedObject var ratingBottomSheetViewModel: RatingBottomSheetViewModel
    @Binding var isPresented: Bool
    let movieId: Int
    let isGuest: Bool
    
    var body: some View {
        HStack(spacing: 12.dhs) {
            //MARK: - Cancel Button
            Button(action: { isPresented.toggle() }) {
                Text("Cancel")
            }
            .buttonStyle(GrayButton())
            //MARK: - Submit Button
            
            if isGuest {
                Button(action: coordinator.logout) {
                    Text("Sign in")
                }
                .buttonStyle(MovaButton())
            } else {
                Button(action: {
                    if ratingBottomSheetViewModel.rateValue != ratingBottomSheetViewModel.tempRateValue {
                        if ratingBottomSheetViewModel.rateValue == 0 {
                            ratingBottomSheetViewModel.deleteRating(movieId: movieId)
                        } else {
                            ratingBottomSheetViewModel.rateMovie(movieId: movieId, rateValue: Double(ratingBottomSheetViewModel.rateValue))
                        }
                    }
                    isPresented.toggle()
                }) {
                    Text("Submit")
                }
                .buttonStyle(MovaButton())
            }
            
        }
        .frame(height: 58.dvs)
    }
}

struct RatingBottomSheetTitle: View {
    var body: some View {
        Text("Give Rating")
            .font(.Urbanist.Bold.size(of: 24.dfs))
            .foregroundColor(.RatingBottomSheet.titleText)
    }
}

struct RatingBottomSheetHandle: View {
    var body: some View {
        Capsule()
            .foregroundColor(.RatingBottomSheet.detentHandle)
            .frame(width: 38.dhs, height: 3.dvs)
            .padding(.top, 8.dvs)
    }
}

struct RatingBottomSheetBackground: View {
    var body: some View {
        Color(Color.RatingBottomSheet.background)
            .ignoresSafeArea()
            .cornerRadius(40, corners: [.topLeft, .topRight])
    }
}
