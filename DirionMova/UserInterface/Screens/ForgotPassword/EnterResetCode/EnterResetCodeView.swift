//
//  EnterResetCodeView.swift
//  DirionMova
//
//  Created by Юрий Альт on 01.12.2022.
//

import SwiftUI

//MARK: - Root View
struct EnterResetCodeView: View {
    @StateObject private var viewModel = EnterResetCodeViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    let type: ResetContactType
    let text: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Color(Color.EnterResetCode.background)
                .ignoresSafeArea()
            VStack {
                VStack {
                    ForgotPasswordHeaderView(titleText: "Forgot Password")
                        .padding(.top, 34.dvs)
                    TopInfoTextView(text: text)
                        .padding(.top, 94.dvs)
                    HStack(spacing: 16.dhs) {
                        ForEach(0...3, id: \.self) { value in
                            OTPElementView(
                                text: viewModel.getValue(for: value),
                                isSelected: viewModel.otp.count - 1 == value && value != 3
                            )
                        }
                    }
                    .frame(height: 61.dvs)
                    .padding(.vertical, 60.dvs)
                    CodeResendTimerView(selectedSecs: $viewModel.selectedSecs)
                        .padding(.bottom, 85.dvs)
                    RedMovaButton(
                        action: { coordinator.show(.enterNewPass) },
                        isActive: viewModel.otp.count == 4,
                        text: "Verify"
                    )
                    .frame(height: 55.dvs)
                }
                .padding(.horizontal, 24.dhs)
                Spacer()
                    .frame(height: 24.dvs)
                PinCustomKeyboard(text: $viewModel.otp, customKey: .custom("*"), customAction: nil)
                    .frame(height: 272.dvs)
            }
        }
        .onAppear {
            viewModel.startTimer()
        }
    }
}

//MARK: - Subviews
struct TopInfoTextView: View {
    let text: String
    var body: some View {
        VStack {
            Text("Code has been send to")
                .font(.Urbanist.Medium.size(of: 18.dfs))
                .foregroundColor(.EnterResetCode.topInfoText)
                .lineLimit(nil)
            .multilineTextAlignment(.leading)
            Text(text)
                .font(.Urbanist.Bold.size(of: 18.dfs))
                .foregroundColor(.EnterResetCode.topInfoText)
                .lineLimit(nil)
            .multilineTextAlignment(.leading)
        }
    }
}

struct CodeResendTimerView: View {
    @Binding var selectedSecs: Int
    var body: some View {
        HStack(spacing: 0) {
            Text("Resend code in ")
                .foregroundColor(.EnterResetCode.timeCounterText)
            Text("\(selectedSecs)")
                .foregroundColor(.EnterResetCode.counterSecondsText)
            Text(" s")
                .foregroundColor(.EnterResetCode.timeCounterText)
        }
        .font(.Urbanist.Medium.size(of: 18.dfs))
    }
}

struct OTPElementView: View {
    let text: String
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isSelected ? Color.EnterResetCode.otpElementBackSelected : Color.EnterResetCode.otpElementBack)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? Color.EnterResetCode.otpElementBorderSelected : Color.EnterResetCode.otpElementBorder, lineWidth: 1))
            Text(text)
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .foregroundColor(.EnterResetCode.otpNumbersText)
                .animation(.easeInOut)
        }
    }
}

//MARK: - Preview
struct EnterResetCodeView_Previews: PreviewProvider {
    static var previews: some View {
        EnterResetCodeView(type: .email, text: "MishaAndAmal@privet.com")
    }
}
