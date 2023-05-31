//
//  PrivacyPolicyElementView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 10.01.2023.
//

import SwiftUI

struct PrivacyPolicyElementView: View {
    let privacyPolicyModel: PrivacyPolicyElementModel
    
    var body: some View {
        VStack(spacing: 24.dvs) {
            HStack {
                Text(privacyPolicyModel.title)
                    .font(.Urbanist.Bold.size(of: 20.dfs))
                    .foregroundColor(.HelpCenter.titleText)
                Spacer()
            }
            Text(privacyPolicyModel.description)
                .font(.Urbanist.Regular.size(of: 14.dfs))
                .lineSpacing(3)
        }
    }
}

struct PrivacyPolicyElementView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyElementView(privacyPolicyModel: PrivacyPolicyElementModel(title: "1. Types of Data We Collect", description:
"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
    A. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.
    B. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"""
))
    }
}
