//
//  AddNewCardView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 16.12.2022.
//

import SwiftUI

struct AddNewCardView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @State private var rememberChecked = false
    @ObservedObject private var addCardViewModel = AddCardViewModel()
    @ObservedObject var paymentViewModel: PaymentViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.SubscribeToPremium.background
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 24.dvs) {
                MocardView(cardName: addCardViewModel.cardName, cardNumber: addCardViewModel.cardNumber, expiryDateMonth: addCardViewModel.expiryDateMonth, expiryDateYear: addCardViewModel.expiryDateYear)
                Divider()
                    .foregroundColor(.SubscribeToPremium.horisontalDevider)
                VStack(spacing: 12.dvs) {
                    HStack {
                        Text("Card Holder Name")
                            .font(.Urbanist.Bold.size(of: 18.dfs))
                        .foregroundColor(.AddNewCard.textColor)
                        Spacer()
                    }
                    CardTextField(text: $addCardViewModel.cardName, type: .cardName)
                }
                VStack(spacing: 12.dvs) {
                    HStack {
                        Text("Card Number")
                            .font(.Urbanist.Bold.size(of: 18.dfs))
                        .foregroundColor(.AddNewCard.textColor)
                        Spacer()
                    }
                    CardTextField(text: $addCardViewModel.cardNumber, type: .cardNumber)
                }
                
                HStack(spacing: 20.dhs) {
                    VStack(spacing: 12.dvs) {
                        HStack {
                            Text("Expiry Date")
                                .font(.Urbanist.Bold.size(of: 18.dfs))
                            .foregroundColor(.AddNewCard.textColor)
                            Spacer()
                        }
                        HStack {
                            CardTextField(text: $addCardViewModel.expiryDateMonth, type: .expiryDateMonth)
                            Text("/")
                            CardTextField(text: $addCardViewModel.expiryDateYear, type: .expiryDateYear)
                        }
                    }
                    VStack(spacing: 12.dvs) {
                        HStack {
                            Text("CVV")
                                .font(.Urbanist.Bold.size(of: 18.dfs))
                            .foregroundColor(.AddNewCard.textColor)
                            Spacer()
                        }
                        CardTextField(text: $addCardViewModel.cardCVV, type: .cardCVV)
                    }
                }
                HStack(spacing: 12.dhs) {
                    CheckBoxView(checked: $rememberChecked)
                    Text("Remember me")
                        .font(.Urbanist.Medium.size(of: 14.dfs))
                }
                Spacer()
                Button("Add") {
                    addCardViewModel.isDisplaySuccessPopUp.toggle()
                }
                .frame(height: 58.dvs, alignment: .center)
                .buttonStyle(MovaButton(isButtonActive: addCardViewModel.fieldsIsValid))
                .disabled(!addCardViewModel.fieldsIsValid)
                .padding(.bottom, 48.dvs)
            }
            .ignoresSafeArea()
            .padding(.horizontal, 24.dhs)
            .padding(.top, 21.dvs)
            
            PopupWithButtonView(viewType: .addedCard, isDisplayed: $addCardViewModel.isDisplaySuccessPopUp) {
                let mocard = Mocard(cardName: addCardViewModel.cardName, cardNumber: addCardViewModel.cardNumber, expiryDateMonth: addCardViewModel.expiryDateMonth, expiryDateYear: addCardViewModel.expiryDateYear)
                
                addCardViewModel.saveNewCard(mocard)
                paymentViewModel.selected = .mocard
                paymentViewModel.isNeedToReloadToggle.toggle()
                coordinator.pop()
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: ScanButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                NewCardHeader()
            }
        }
    }
}

struct AddNewCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewCardView(paymentViewModel: PaymentViewModel())
    }
}

struct NewCardHeader: View {
    var body: some View {
        HStack {
            Text("Add New Card")
                .font(Font.Urbanist.Bold.size(of: 24.dfs))
                .multilineTextAlignment(.leading)
                .padding(.leading, 16.dhs)
            Spacer()
        }
    }
}
