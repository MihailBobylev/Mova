//
//  DownloadButtonView.swift
//  DirionMova
//
//  Created by Юрий Альт on 14.11.2022.
//

import SwiftUI

struct DownloadButtonView: View {
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Capsule()
                    .foregroundColor(Color.clear)
                    .frame(height: 38.dvs)
                    .overlay(
                        Capsule().stroke(Color(.MOVA.primary500), lineWidth: 2)
                    )
                HStack {
                    Image("downloadSelected")
                        .frame(width: 20, height: 20)
                    Text("Download")
                        .font(Font.Urbanist.SemiBold.size(of: 16.dfs))
                        .foregroundColor(.MovieDetails.downloadButtonText)
                }
            }
        }
    }
}

struct DownloadButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadButtonView(action: {})
    }
}



