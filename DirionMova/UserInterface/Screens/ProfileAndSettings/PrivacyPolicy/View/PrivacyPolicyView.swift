//
//  PrivacyPolicyView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 10.01.2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @ObservedObject private var privacyPolicyViewModel = PrivacyPolicyViewModel()
    
    var body: some View {
        ZStack {
            Color.HelpCenter.background
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                Divider()
                    .opacity(0)
                ZStack(alignment: .top) {
                    ScrollView {
                        LazyVStack(spacing: 24.dvs) {
                            Text(privacyPolicyViewModel.prefixString)
                                .font(.Urbanist.Regular.size(of: 14.dfs))
                            ForEach(privacyPolicyViewModel.policyElements) { element in
                                PrivacyPolicyElementView(privacyPolicyModel: element)
                            }
                        }
                        .padding(.top, 24.dvs)
                    }
                }
            }
            .padding(.horizontal, 24.dhs)
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButton())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Privacy Policy")
                        .font(.Urbanist.Bold.size(of: 24.dfs))
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 16.dhs)
                    Spacer()
                }
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
