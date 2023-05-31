//
//  ContactTypeView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 28.12.2022.
//

import SwiftUI

struct ContactTypeView: View {
    let type: ContactType
    let tapAction: () -> ()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.HelpCenter.tileBack)
            HStack(spacing: 16.dhs) {
                Image(type.image)
                    .resizable()
                    .frame(width: 24.dhs, height: 24.dvs)
                Text(type.title)
                    .font(.Urbanist.Bold.size(of: 18.dfs))
                    .foregroundColor(.HelpCenter.titleText)
                Spacer()
            }
            .padding([.vertical, .horizontal], 24.dhs)
        }
        .shadow(color: .HelpCenter.tileShadow, radius: 20, x: 0, y: 4)
        .onTapGesture {
            tapAction()
        }
    }
}

struct ContactTypeView_Previews: PreviewProvider {
    static var previews: some View {
        ContactTypeView(type: .customerService){}
    }
}
