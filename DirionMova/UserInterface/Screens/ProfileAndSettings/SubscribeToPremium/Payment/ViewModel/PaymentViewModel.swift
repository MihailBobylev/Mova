//
//  PaymentViewModel.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.12.2022.
//

import Foundation

class PaymentViewModel: ObservableObject {
    @Published var isNeedToReloadToggle = false
    @Published var isDisplayErrorPopUp = false
    @Published var clearCardInfo = false
    @Published var selected: PaymentMethodType = .none
}
