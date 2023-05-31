//
//  MovaTextField.swift
//  DirionMova
//
//  Created by Юрий Альт on 29.11.2022.
//

import SwiftUI

struct MovaTextField: UIViewRepresentable {
    @Binding var isFirstResponder: Bool
    @Binding var text: String
    let type: SelectedTextField
    let isSecured: Bool

    var configuration = { (view: UITextField) in }

    init(text: Binding<String>, type: SelectedTextField, isSecured: Bool, isFirstResponder: Binding<Bool>, configuration: @escaping (UITextField) -> () = { _ in }) {
        self.configuration = configuration
        self._text = text
        self.type = type
        self.isSecured = isSecured
        self._isFirstResponder = isFirstResponder
    }

    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        switch type {
        case .cardName, .cardNumber, .cardCVV, .expiryDateMonth, .expiryDateYear, .confirmPassword, .createPassword, .password:
            view.autocorrectionType = .no
        default:
            view.autocorrectionType = .yes
        }
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        var regex: String {
            switch type {
            case .fullName, .cardName:
                return "[^A-Za-z ]"
            case .name:
                return "[^A-Za-z ]"
            case .searchField:
                return "^[A-Za-z0-9!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~] "
            case .cardCVV, .expiryDateMonth, .expiryDateYear:
                return "[^0-9]"
            case .cardNumber:
                return "[^0-9 ]"
            default:
                return "^[A-Za-z0-9!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~@]"
            }
        }
        
        var tmp = text.replacingOccurrences(
            of: regex,
            with: "",
            options: .regularExpression
        )
        tmp = tmp.replacingOccurrences(
            of: "^ ",
            with: "",
            options: .regularExpression
        )
        tmp = tmp.replacingOccurrences(
            of: " {2,}",
            with: " ",
            options: .regularExpression
        )
        uiView.text = tmp

        if isSecured && !text.isEmpty {
            uiView.defaultTextAttributes.updateValue(-2, forKey: NSAttributedString.Key.kern)
            uiView.font = UIFont.systemFont(ofSize: 24.dfs, weight: .bold)
        } else {
            uiView.defaultTextAttributes.updateValue(0, forKey: NSAttributedString.Key.kern)
            uiView.font = UIFont(name: "Urbanist-SemiBold", size: 14.dfs)
        }
        
        uiView.placeholder = type.placeholder
        uiView.isSecureTextEntry = isSecured
        
        switch type {
        case .phoneNumber:
            uiView.keyboardType = .asciiCapableNumberPad
        case .fullPhoneNumber:
            uiView.keyboardType = .phonePad
        case .cardNumber, .cardCVV, .expiryDateMonth, .expiryDateYear:
            uiView.keyboardType = .numbersAndPunctuation
        default:
            uiView.keyboardType = .asciiCapable
        }
        
        DispatchQueue.main.async {
            switch isFirstResponder {
            case true: uiView.becomeFirstResponder()
            case false: uiView.resignFirstResponder()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>

        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>) {
            self.text = text
            self.isFirstResponder = isFirstResponder
        }

        @objc func textViewDidChange(_ textField: UITextField) {
            self.text.wrappedValue = textField.text ?? ""
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isFirstResponder.wrappedValue = true
            }
        }

        func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.isFirstResponder.wrappedValue = false
            }
        }
        
        func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
            UIApplication.shared.dismissKeyboard()
            return true
        }
    }
}
