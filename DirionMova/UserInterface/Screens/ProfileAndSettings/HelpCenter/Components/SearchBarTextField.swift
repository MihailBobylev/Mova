//
//  SearchBarTextField.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//
import SwiftUI

struct SearchBarTextField: UIViewRepresentable {
    @Binding var isFirstResponder: Bool
    @Binding var text: String
    
    let commitAction: () -> ()
    
    var configuration = { (view: UITextField) in }

    init(text: Binding<String>, isFirstResponder: Binding<Bool>, commitAction: @escaping () -> (), configuration: @escaping (UITextField) -> () = { _ in }) {
        self.configuration = configuration
        self._text = text
        self._isFirstResponder = isFirstResponder
        self.commitAction = commitAction
    }

    func makeUIView(context: Context) -> UITextField {
        let view = UITextField()

        view.autocorrectionType = .yes
        
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }

    func updateUIView(_ uiView: UITextField, context: Context) {
        var regex: String {
            return "[^A-Za-z ]"
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
        uiView.font = UIFont(name: "Urbanist-SemiBold", size: 14.dfs)
        
        uiView.placeholder = "Search"
        uiView.keyboardType = .asciiCapable

        DispatchQueue.main.async {
            switch isFirstResponder {
            case true: uiView.becomeFirstResponder()
            case false: uiView.resignFirstResponder()
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder, commitAction: commitAction)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        let commitAction: () -> ()
        
        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>, commitAction: @escaping () -> ()) {
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.commitAction = commitAction
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
            commitAction()
            UIApplication.shared.dismissKeyboard()
            return true
        }
    }
}
