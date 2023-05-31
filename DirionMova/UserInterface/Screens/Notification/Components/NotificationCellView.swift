//
//  NotificationCellView.swift
//  DirionMova
//
//  Created by Юрий Альт on 05.12.2022.
//

import SwiftUI
import Kingfisher

struct NotificationCellView: View {
    let action: () -> ()
    let imageURL: String
    let name: String
    let date: String
    
    var body: some View {
        Button(action: action) {
            HStack {
                KFImage(URL(string: imageURL))
                    .resizable()
                    .placeholder {
                        Color(.MOVA.greyscale300)
                            .frame(width: 186.dhs, height: 248.dvs)
                            .shimmer()
                            .cornerRadius(10)
                    }
                    .cornerRadius(10)
                    .frame(width: 186.dhs, height: 248.dvs)
                Text(name)
                    .padding(.leading, 20.dhs)
                    .padding(.trailing, 12.dhs)
                    .font(Font.Urbanist.Bold.size(of: 18.dfs))
                    .foregroundColor(.Notification.nameText)
                    .multilineTextAlignment(.leading)
                Spacer()
                Text(date)
                    .font(Font.Urbanist.Regular.size(of: 10.dfs))
                    .foregroundColor(.Notification.dateText)
            }
        }
    }
}

struct NotificationCellView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCellView(action: {}, imageURL: "", name: "", date: "")
    }
}
