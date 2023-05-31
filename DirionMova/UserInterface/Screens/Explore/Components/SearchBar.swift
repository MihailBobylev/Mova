//
//  SearchBar.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 01.11.2022.
//

import SwiftUI

enum TabItemType {
    case explore
    case myList
}

struct SearchBar: View {
    @Binding var text: String
    @Binding var isFocused: Bool
    @Binding var tabItemType: TabItemType
    
    let changeAction: () -> ()
    let commitAction: () -> ()
    let clearAction: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFocused ? Color(UIColor.MOVA.primary500.withAlphaComponent(0.08)) : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFocused ? Color(UIColor.MOVA.primary500) : Color(UIColor.clear)))
            
            HStack {
                Image(isFocused ? "searchRed" : "searchGray")
                    .foregroundColor(.black)
                
                TextField("Search", text: $text, onCommit: {
                    isFocused = false
                    commitAction()
                })
                .onChange(of: text, perform: { newWalue in
                    if containsValidCharacter() {
                        changeAction()
                    }
                })
                .onTapGesture {
                    isFocused = true
                }
                .font(Font.Urbanist.Regular.size(of: 14.dfs))
                
                Spacer()
                
                Button {
                    withAnimation {
                        UIApplication.shared.dismissKeyboard()
                        clearAction()
                    }
                } label: {
                    getClearImage()
                        .resizable()
                        .foregroundColor(Color(UIColor.systemGray6))
                        .frame(width: 24, height: 24)
                }
                .opacity((tabItemType == .explore && !text.isEmpty) || tabItemType == .myList ? 1 : 0)
            }
            .padding(5)
            .padding([.leading, .trailing], 6)
            .frame(maxWidth: .infinity)
        }
        .frame(height: 56.dvs, alignment: .center)
    }
    
    private func getClearImage() -> Image {
        switch tabItemType {
        case .explore:
            return Image(!text.isEmpty && !isFocused ? "closeSquareGray" : "closeSquareRed")
        case .myList:
            return Image(text.isEmpty && !isFocused ? "closeSquareGray" : "closeSquareRed")
        }
    }
    
    private func containsValidCharacter() -> Bool {
        guard !text.isEmpty else { return true }
        
        let invalidCharacters = "!@#$%^&*()_+{}[]|\"<>,.~`/:;?-=\\¥'£•¢"
        let invalidSet = CharacterSet(charactersIn: invalidCharacters)
        
        if let _ = text.rangeOfCharacter(from: invalidSet) {
            text = text.filter { !invalidCharacters.contains($0) }
            return false
        } else {
            return true
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""), isFocused: .constant(true), tabItemType: .constant(.explore)) {
            
        } commitAction: {
            
        } clearAction: {}
    }
}
