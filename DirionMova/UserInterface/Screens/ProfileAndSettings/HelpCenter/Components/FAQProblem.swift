//
//  FAQProblem.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 27.12.2022.
//

import SwiftUI

struct FAQProblem: View {
    @State var showDescription = false
    @State var show = false
    @ObservedObject var faqViewModel: FAQViewModel
    let faqProblemModel: FAQProblemModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.HelpCenter.tileBack)
            VStack(spacing: 16.dvs) {
                HStack {
                    Text(faqProblemModel.title)
                        .font(.Urbanist.Bold.size(of: 18.dfs))
                        .foregroundColor(.HelpCenter.titleText)
                    Spacer()
                    Image("arrowDownRed")
                        .resizable()
                        .frame(width: 24.dhs, height: 24.dvs)
                }
                if showDescription {
                    VStack(spacing: 0) {
                        if show {
                            VStack(spacing: 16.dvs) {
                                Divider()
                                    .foregroundColor(.HelpCenter.divider)
                                HStack {
                                    Text(faqProblemModel.description)
                                        .font(.Urbanist.Medium.size(of: 14.dfs))
                                        .foregroundColor(.HelpCenter.descriprionText)
                                        .multilineTextAlignment(.leading)
                                        .fixedSize(horizontal: false, vertical: true)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .onAppear {
                        show = true
                    }
                    .onDisappear {
                        show = false
                    }
                    .animation(Animation.spring().delay(0.1), value: show)
                }
            }
            .padding([.horizontal, .vertical], 24.dhs)
        }
        .shadow(color: .HelpCenter.tileShadow, radius: 20, x: 0, y: 4)
        .onTapGesture {
            faqViewModel.filteredFAQ.removeAll()
            UIApplication.shared.dismissKeyboard()
            showDescription.toggle()
        }
        .onChange(of: faqViewModel.openProblemToggle) { _ in
            showDescription = faqViewModel.openedProblemTitle == faqProblemModel.title
        }
        .onAppear {
            showDescription = faqViewModel.openedProblemTitle == faqProblemModel.title
        }
    }
}

struct FAQProblem_Previews: PreviewProvider {
    static var previews: some View {
        FAQProblem(faqViewModel: FAQViewModel(), faqProblemModel: FAQProblemModel(title: "I forgot my password. What should I do?", description: "If you entered an email – use the \"Remind password\" function in the login form", type: .account))
            .padding(.horizontal, 24.dhs)
    }
}
