//
//  EnterResetCodeViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 01.12.2022.
//

import SwiftUI

class EnterResetCodeViewModel: ObservableObject {
    //MARK: - Binding Properties
    @Published var otp = "" {
        didSet {
            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
            impactMed.impactOccurred()
        }
    }
    @Published var timer: Timer?
    @Published var selectedSecs = 60
    
    //MARK: - Public Methods
    func getValue(for indexValue: Int) -> String {
        var value = ""
        if indexValue < otp.count {
            let index = otp.index(otp.startIndex, offsetBy: indexValue)
            value = String(otp[index])
        }
        return value
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.selectedSecs -= 1
            if self.selectedSecs == 0 {
                self.timer?.invalidate()
                self.selectedSecs = 60
                self.startTimer()
            }
        }
    }
}
