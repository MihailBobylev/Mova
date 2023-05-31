//
//  PinTextBox.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/11/22.
//

import SwiftUI

struct PinTextBox: View {
    
    @Binding var password: String
    @Binding var isError: Bool
    var isSecure: Bool
    
    var body: some View {
        HStack(spacing: 16.dhs) {
            ForEach(1...4, id: \.self) { value in
                PinTextBoxCircle(isSecure: isSecure,
                                 index: value,
                                 isError: $isError,
                                 password: $password)
            }
        }
        .frame(height: 120.dvs)
        .padding([.trailing, .leading], 24.dhs)
    }
}

struct PinTextBox_Previews: PreviewProvider {
    static var previews: some View {
        PinTextBox(password: .constant("123"), isError: .constant(true), isSecure: true)
    }
}

struct PinTextBoxCircle: View {
    var isSecure: Bool
    var index: Int
    @Binding var isError: Bool
    @Binding var password: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .stroke(isError ? Color.Pin.boxCornerErrorColor : Color.Pin.pinBoxCornerColor,
                        lineWidth: 1)
                .background(isError ? Color.Pin.boxErrorColor : Color.Pin.pinBoxBackgroundColor)
                .cornerRadius(12)
                .padding([.top, .bottom], 24.dvs)
            if isSecure {
                secureCircle
                    .opacity(password.count >= index ? 1 : 0)
                    .animation(.easeInOut)
            } else {
                notSecureText
            }
        }
    }
}

extension PinTextBoxCircle {
    var secureCircle: some View {
        Image("pinCircle")
            .resizable()
            .frame(width: 24, height: 24)
            .padding(.all, 24)
    }
    
    //TODO: Not secure part not ready
    var notSecureText: some View {
        Text("1")
            .foregroundColor(Color(UIColor.MOVA.greyscale900))
            .font(Font.Urbanist.Medium.size(of: 24.dfs))
    }
}

