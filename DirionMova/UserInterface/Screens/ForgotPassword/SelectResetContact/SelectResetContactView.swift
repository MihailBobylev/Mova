//
//  SelectResetContactView.swift
//  DirionMova
//
//  Created by Юрий Альт on 01.12.2022.
//

import SwiftUI

//MARK: - Enum With Type Of Forgot Password Elements
enum ResetContactType {
    case sms
    case email
    case none
    
    var description: String {
        switch self {
        case .sms:
            return "via SMS:"
        case .email:
            return "via Email:"
        case .none:
            return ""
        }
    }
    
    var value: String {
        switch self {
        case .sms:
            return "+1 111 ******99"
        case .email:
            return "and***ley@yourdomain.com"
        case .none:
            return ""
        }
    }
    
    var imageName: String {
        switch self {
        case .sms:
            return "chatBoldRed"
        case .email:
            return "messageBoldRedNew"
        default:
            return ""
        }
    }
}

//MARK: - Root View
struct SelectResetContactView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @State private var selectedType: ResetContactType = .none
    
    var body: some View {
        ZStack {
            Color(Color.CreateAccount.background)
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ForgotPasswordHeaderView(titleText: "Forgot Password")
                    .padding(.top, 34.dvs)
                Image("selectContact")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250.dhs, height: 244.dvs)
                    .padding(.top, 36.dvs)
                Text("Select which contact details should we use to reset your password")
                    .font(.Urbanist.Medium.size(of: 18.dfs))
                    .foregroundColor(.SelectResetContact.descriptionText)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 36.dvs)
                ContactView(selectedType: $selectedType, type: .sms)
                    .padding(.top, 24.dvs)
                ContactView(selectedType: $selectedType, type: .email)
                    .padding(.top, 24.dvs)
                RedMovaButton(
                    action: { coordinator.show(.enterResetCode(type: selectedType, text: selectedType.value)) },
                    isActive: selectedType != .none,
                    text: "Continue"
                )
                .frame(height: 58.dvs)
                .padding(.top, 36.dvs)
                Spacer()
            }
            .padding(.horizontal, 24.dhs)
        }
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
}

//MARK: - Subviews
struct ContactView: View {
    @Binding var selectedType: ResetContactType
    let type: ResetContactType
    
    var body: some View {
        Button(action: { selectedType = type }) {
            ZStack {
                RoundedRectangle(cornerRadius: 32)
                    .fill(Color.SelectResetContact.contactButtonBack)
                    .overlay(
                        RoundedRectangle(cornerRadius: 32)
                            .stroke(
                                selectedType == type ? Color.SelectResetContact.selectedContactBorder :
                                    Color.SelectResetContact.unselectedContactBorder,
                                lineWidth: selectedType == type ? 3 : 1)
                    )
                HStack(spacing: 20.dhs) {
                    ZStack {
                        Circle()
                            .fill(Color.SelectResetContact.contactCircle)
                            .frame(height: 80.dvs)
                        Image(type.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32.dhs, height: 32.dvs)
                    }
                    VStack(spacing: 8.dvs) {
                        Spacer()
                        HStack {
                            Text(type.description)
                                .font(.Urbanist.Medium.size(of: 14.dfs))
                                .foregroundColor(.SelectResetContact.contactTypeText)
                            Spacer()
                        }
                        HStack {
                            Text(type.value)
                                .font(.Urbanist.Bold.size(of: 16.dfs))
                                .foregroundColor(.SelectResetContact.contactDataText)
                                .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        Spacer()
                    }
                }
                .padding([.leading, .trailing], 24.dhs)
                .padding([.top, .bottom], 24.dvs)
            }
            .frame(height: 128.dvs)
        }
    }
}

struct ForgotPasswordHeaderView: View {
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    let titleText: String
    var body: some View {
        HStack {
            Button(action: { coordinator.pop() }) {
                Image("arrowLeftLight")
            }
            Text(titleText)
                .padding(.leading, 16.dhs)
                .font(.Urbanist.Bold.size(of: 24.dfs))
                .foregroundColor(.SelectResetContact.titleText)
            Spacer()
        }
    }
}

//MARK: - Preview
struct SelectResetContactView_Previews: PreviewProvider {
    static var previews: some View {
        SelectResetContactView()
    }
}
