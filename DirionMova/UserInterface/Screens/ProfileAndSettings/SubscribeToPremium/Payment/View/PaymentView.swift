//
//  PaymentView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 15.12.2022.
//

import SwiftUI

struct PaymentView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    @ObservedObject private var paymentViewModel = PaymentViewModel()
    @State var isNeedToRefreshToggle = false
    let rate: SubscribeToPremiumType
    
    var body: some View {
        ZStack {
            Color.Payment.paymentBackground
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 32.dvs) {
                HStack {
                    Text("Select the payment method you want to use.")
                        .font(.Urbanist.Medium.size(of: 16.dfs))
                    .foregroundColor(.Payment.rowText)
                    Spacer()
                }
                .padding(.top, 21.dvs)
                PaymentMethod(type: .payPal, selected: $paymentViewModel.selected)
                PaymentMethod(type: .googlePay, selected: $paymentViewModel.selected)
                PaymentMethod(type: .applePay, selected: $paymentViewModel.selected)
                if let _mocard = storage.addNewCard {
                    PaymentMethod(type: .mocard, mocard: _mocard, selected: $paymentViewModel.selected)
                }
                Button("Add New Card") {
                    paymentViewModel.clearCardInfo = false
                    coordinator.show(.addNewCard(paymentViewModel: paymentViewModel))
                }
                .frame(height: 58.dvs, alignment: .center)
                .buttonStyle(AddCardStyle())
                Spacer()
                Button("Continue") {
                    if paymentViewModel.selected == .mocard {
                        if let _mocard = storage.addNewCard {
                            paymentViewModel.clearCardInfo = false
                            coordinator.show(.reviewSummary(rate: rate, mocard: _mocard))
                        }
                    } else {
                        paymentViewModel.isDisplayErrorPopUp.toggle()
                    }
                }
                .disabled(paymentViewModel.selected == .none)
                .frame(height: 58.dvs, alignment: .center)
                .padding(.bottom, 48.dvs)
                .buttonStyle(MovaButton(isButtonActive: paymentViewModel.selected != .none))
            }
            .padding([.leading, .trailing], 24.dhs)
            
            PopupWithButtonView(viewType: .serviceIsTemporaryUnavailable, isDisplayed: $paymentViewModel.isDisplayErrorPopUp)
        }
        .onDisappear {
            if paymentViewModel.clearCardInfo {
                DispatchQueue.main.async {
                    storage.deleteMocard()
                }
            }
        }
        .onAppear {
            paymentViewModel.clearCardInfo = true
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: ScanButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                PaymentHeader()
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(rate: .year)
    }
}

struct PaymentHeader: View {
    var body: some View {
        HStack {
            Text("Payment")
                .font(Font.Urbanist.Bold.size(of: 24.dfs))
                .multilineTextAlignment(.leading)
                .padding(.leading, 16.dhs)
            Spacer()
        }
    }
}

struct ScanButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image("scan")
        }

    }
}
