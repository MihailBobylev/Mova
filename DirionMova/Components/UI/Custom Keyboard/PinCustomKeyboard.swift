//
//  PinCustomKeyboard.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/11/22.
//

import SwiftUI

struct PinCustomKeyboard: View {
    
    @Binding var text: String
    var customKey: KeyboardKeys?
    var customAction: (()-> Void)? = nil
    
    var body: some View {
        ZStack {
            Color(Color.Pin.pinKeyboardBack)
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .edgesIgnoringSafeArea(.all)
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 15.dvs) {
                ForEach(KeyboardKeys.allCases, id: \.self) { key in
                    switch key {
                    case .custom:
                        PinButton(key: customKey, text: $text, customAction: customAction)
                    case .delete:
                        PinButton(key: key, text: $text)
                            .opacity(text.isEmpty ? 0 : 1)
                    default:
                        PinButton(key: key, text: $text)
                    }
                }
            }
        }
    }
}

struct PinCustomKeyboard_Previews: PreviewProvider {
    static var previews: some View {
        PinCustomKeyboard(text: .constant("123"), customKey: .custom("Skip"))
    }
}

struct PinButton: View {
    
    var key: KeyboardKeys?
    var image: String? = nil
    @Binding var text: String
    var customAction: (()-> Void)? = nil
    
    var body: some View {
        Button(action: setText) {
            switch key {
            case .delete:
                Image("deleteLeft")
                    .frame(width: 28, height: 28)
            case .custom:
                Text(key?.text ?? "")
                    .font(Font.Urbanist.Regular.size(of: 18.dfs))
                    .foregroundColor(.Pin.pinKeyboardText)
                    .padding([.leading, .trailing], 7.dhs)
                    .padding([.top, .bottom], 7.dvs)
            default:
                Text(key?.text ?? "")
                    .font(Font.Urbanist.Medium.size(of: 24.dfs))
                    .foregroundColor(.Pin.pinKeyboardText)
                    .padding([.leading, .trailing], 7.dhs)
                    .padding([.top, .bottom], 7.dvs)
            }
        }
    }
    
    func setText() {
        switch key {
        case .custom:
            customAction?()
        case .delete:
            guard text.count != 0 else { return }
            text.removeLast()
        default:
            guard text.count < 4 else { return }
            text.append(key?.text ?? "")
        }
    }
}
