//
//  SplashScreenView.swift
//  DirionMova
//
//  Created by Юрий Альт on 14.11.2022.
//

import SwiftUI

struct SplashScreenView: View {
    let viewModel = SplashScreenViewModel()
    var body: some View {
        ZStack {
            Color(Color.SplashScreen.background)
                .ignoresSafeArea()
            Image("AppLogo")
                .resizable()
                .frame(width: 117.33, height: 117.33)
            VStack {
                LoadingIndicatorView(size: 60)
                    .frame(width: 60, height: 60)
                    .padding(.bottom, 146.dvs)
            }
            .frame(height: UIScreen.main.bounds.height, alignment: .bottom)
        }
        .ignoresSafeArea()
        .onAppear {
            viewModel.renewGuestSession()
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
