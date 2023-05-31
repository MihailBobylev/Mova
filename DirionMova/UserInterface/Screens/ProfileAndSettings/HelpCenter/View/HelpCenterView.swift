//
//  HelpCenterView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import SwiftUI

struct HelpCenterView: View {
    @ObservedObject private var helpCenterViewModel = HelpCenterViewModel()
    @ObservedObject private var faqViewModel = FAQViewModel()
    
    @Environment(\.safeAreaInsets.top) private var safeAreaInsetsTop
    @State var searchBarOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.HelpCenter.background
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Divider()
                    .opacity(0)
                ScrollViewReader { reader in
                    ZStack(alignment: .topLeading) {
                        ScrollView(showsIndicators: false) {
                            VStack(spacing: 24.dvs) {
                                HelpCenterDetailsButton(currentIndex: $helpCenterViewModel.componentsIndex) { index in
                                    faqViewModel.clearSearchState()
                                }
                                    .padding(.horizontal, 24.dhs)
                                
                                if helpCenterViewModel.componentsIndex == 0 {
                                    FAQView(faqViewModel: faqViewModel, searchBarOffsetY: $searchBarOffsetY)
                                } else if helpCenterViewModel.componentsIndex == 1 {
                                    ContactUsView() {
                                        helpCenterViewModel.isSorryTopupDisplayed.toggle()
                                    }
                                }
                            }
                            .padding(.top, 24.dvs)
                            .id("Scroll")
                            .overlay(
                                ScrollViewDidMoveOverlay(faqViewModel: faqViewModel) {
                                    scrollAction()
                                }
                            )
                        }
                        FindedFAQView(faqViewModel: faqViewModel, reader: reader)
                            .offset(y: searchBarOffsetY - safeAreaInsetsTop - 40.dvs)
                            .padding(.horizontal, 24.dhs)
                    }
                }
            }
            PopupWithButtonView(viewType: .serviceIsTemporaryUnavailable,
                                isDisplayed: $helpCenterViewModel.isSorryTopupDisplayed)
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton(), trailing: SettingsButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Help Center")
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16.dhs)
                    Spacer()
                }
            }
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onTapGesture {
            faqViewModel.clearSearchState()
        }
        .contentShape(Rectangle())
    }
    
    func scrollAction() {
        if !faqViewModel.filteredFAQ.isEmpty {
            faqViewModel.filteredFAQ.removeAll()
        }
        if faqViewModel.isFirstResponder {
            UIApplication.shared.dismissKeyboard()
        }
    }
}

struct HelpCenterView_Previews: PreviewProvider {
    static var previews: some View {
        HelpCenterView()
    }
}

struct SettingsButton: View {
    var body: some View {
        Button {
            
        } label: {
            Image("settingsIcon")
        }
        
    }
}

struct FindedFAQView: View {
    @ObservedObject var faqViewModel: FAQViewModel
    let reader: ScrollViewProxy
    
    var body: some View {
        VStack(spacing: 16.dvs) {
            ForEach(faqViewModel.filteredFAQ) { problem in
                HStack {
                    Text(problem.title)
                        .font(.Urbanist.SemiBold.size(of: 14.dfs))
                        .foregroundColor(.HelpCenter.titleText)
                    Spacer()
                }
                .padding(.leading, 20.dhs)
                .padding(.trailing, 28.dhs)
                .onTapGesture {
                    withAnimation(.spring()) {
                        faqViewModel.openedProblemID = problem.id
                        faqViewModel.openedProblemTitle = problem.title
                        faqViewModel.openProblemToggle.toggle()
                        faqViewModel.clearSearchState()
                        reader.scrollTo(problem.id)
                    }
                    
                }
                if faqViewModel.filteredFAQ.last != problem {
                    Divider()
                }
            }
        }
        .padding(.vertical, 20.dvs)
        .background(Color.HelpCenter.tileBack.cornerRadius(16))
        .shadow(color: .HelpCenter.tileShadow, radius: 16, x: 0, y: 20)
    }
}
