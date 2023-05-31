//
//  ContactUsView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//

import SwiftUI

struct ContactUsView: View {
    @ObservedObject private var contactUsViewModel = ContactUsViewmodel()
    let tapOnElementAction: () -> ()
    
    var body: some View {
        ZStack {
            VStack(spacing: 24.dvs) {
                ForEach(ContactType.allCases, id: \.self) { type in
                    ContactTypeView(type: type) {
                        tapOnElementAction()
                    }
                }
            }
            .padding(.horizontal, 24.dhs)
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView(){}
    }
}
