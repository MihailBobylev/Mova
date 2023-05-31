//
//  LanguageView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 11.01.2023.
//

import SwiftUI

struct LanguageView: View {
    @ObservedObject private var languageViewModel = LanguageViewModel()
    @Binding var selectedLanguage: String
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.Download.background
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 24.dvs) {
                VStack(alignment: .leading, spacing: 40.dvs) {
                    Text("Suggested")
                        .font(.Urbanist.Bold.size(of: 20.dfs))
                    ForEach(languageViewModel.suggested, id: \.self) { language in
                        LanguageMenuElement(language: language, selected: $selectedLanguage)
                    }
                }
                
                Divider()
                
                VStack(alignment: .leading, spacing: 40.dvs) {
                    Text("Language")
                        .font(.Urbanist.Bold.size(of: 20.dfs))
                    ScrollView {
                        LazyVStack(spacing: 40.dvs) {
                            ForEach(languageViewModel.languages, id: \.self) { language in
                                LanguageMenuElement(language: language, selected: $selectedLanguage)
                            }
                        }
                    }
                }
            }
            .padding(.top, 24.dvs)
            .padding(.horizontal, 24.dhs)
        }
        .onAppear {
            languageViewModel.addInSuggested(language: selectedLanguage)
            languageViewModel.fillLanguages()
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Language")
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16.dhs)
                    Spacer()
                }
            }
        }
    }
}

struct LanguageView_Previews: PreviewProvider {
    static var previews: some View {
        LanguageView(selectedLanguage: .constant("Russian"))
    }
}
