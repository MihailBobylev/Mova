//
//  ReviewSummaryView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.12.2022.
//

import SwiftUI

struct ReviewSummaryView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @ObservedObject private var reviewSummaryViewModel = ReviewSummaryViewModel()
    let rate: SubscribeToPremiumType
    let mocard: Mocard
    
    var body: some View {
        ZStack {
            Color.Payment.paymentBackground
                .ignoresSafeArea()
            VStack(spacing: 32.dvs) {
                SubscribeToPremiumButton(type: rate) {}
                    .disabled(true)
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.ReviewSummary.background)
                    VStack(spacing: 20.dvs) {
                        HStack {
                            Text("Amount")
                                .font(.Urbanist.Medium.size(of: 14.dfs))
                            Spacer()
                            Text("$\(rate.price.roundToTwo)")
                                .font(.Urbanist.SemiBold.size(of: 16.dfs))
                        }
                        .padding(.horizontal, 24.dhs)
                        HStack {
                            Text("Tax")
                                .font(.Urbanist.Medium.size(of: 14.dfs))
                            Spacer()
                            Text("$\(rate.tax.roundToTwo)")
                                .font(.Urbanist.SemiBold.size(of: 16.dfs))
                        }
                        .padding(.horizontal, 24.dhs)
                        
                        Divider()
                            .padding(.horizontal, 24.dhs)
                        
                        HStack {
                            Text("Total")
                                .font(.Urbanist.Medium.size(of: 14.dfs))
                            Spacer()
                            Text("$\(getSummary())")
                                .font(.Urbanist.SemiBold.size(of: 16.dfs))
                        }
                        .padding(.horizontal, 24.dhs)
                    }
                }
                .cornerRadius(16.dfs, corners: .allCorners)
                .frame(height: 174.dvs)
                
                PaymentMethodReview(mocard: mocard) {
                    coordinator.pop()
                }
                
                Spacer()
                
                Button("Confirm Payment") {
                    reviewSummaryViewModel.isDisplaySuccessPopUp.toggle()
                }
                .disabled(false)
                .opacity(1)
                .frame(height: 58.dvs, alignment: .center)
                .padding(.bottom, 48.dvs)
                .buttonStyle(MovaButton())
            }
            .padding(.top, 30.5.dvs)
            .padding(.horizontal, 24.dhs)
            
            PopupWithButtonView(viewType: rate == .month ? .successfullySubscribedMonth : .successfullySubscribedYear, isDisplayed: $reviewSummaryViewModel.isDisplaySuccessPopUp) {
                reviewSummaryViewModel.makeSubscribed()
                coordinator.popTo(viewsToPop: 3)
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                ReviewSummaryHeader()
            }
        }
    }
    
    func getSummary()  -> String {
        let total = rate.price + rate.tax
        return total.roundToTwo
    }
}

struct ReviewSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewSummaryView(rate: .year, mocard: Mocard(cardName: "", cardNumber: "4444 4444 4444 4444", expiryDateMonth: "01", expiryDateYear: "23"))
    }
}

struct ReviewSummaryHeader: View {
    var body: some View {
        HStack {
            Text("Review Summary")
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .multilineTextAlignment(.leading)
                .padding(.leading, 16.dhs)
            Spacer()
        }
    }
}
