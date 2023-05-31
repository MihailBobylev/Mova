//
//  SearchBarFAQ.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import SwiftUI

struct SearchBarFAQ: View {
    @Binding var isFirstResponder: Bool
    @Binding var text: String
    
    let changeAction: () -> ()
    let commitAction: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(isFirstResponder ? Color.HelpCenter.searchBarBackgroundWithAlpha : Color.TexFields.background)
                .overlay(RoundedRectangle(cornerRadius: 12).stroke(lineWidth: 1)
                    .foregroundColor(isFirstResponder ? Color.HelpCenter.searchBarBackground : Color.clear))
            
            HStack {
                Image(isFirstResponder ? "searchRed" : "searchGray")
                    .foregroundColor(.black)
                
                SearchBarTextField(text: $text, isFirstResponder: $isFirstResponder) {
                    commitAction()
                }
                .onChange(of: text, perform: { newWalue in
                        changeAction()
                })
                
                Image("filterFAQ")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            .padding([.leading, .trailing], 20)
            .frame(maxWidth: .infinity)
        }
        .frame(height: 56.dvs, alignment: .center)
    }
    
    private func getClearImage() -> Image {
        return Image(!text.isEmpty && !isFirstResponder ? "closeSquareGray" : "closeSquareRed")
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

struct SearchBarFAQ_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarFAQ(isFirstResponder: .constant(true), text: .constant("")) {
            
        } commitAction: {
            
        }
    }
}
