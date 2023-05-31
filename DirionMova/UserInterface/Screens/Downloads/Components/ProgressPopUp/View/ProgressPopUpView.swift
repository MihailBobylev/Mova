//
//  ProgressPopUpView.swift
//  DirionMova
//
//  Created by Михаил Бобылев on 20.01.2023.
//

import SwiftUI

struct ProgressPopUpView: View {
    @StateObject var viewModel = ProgressPopUpViewModel()
    @EnvironmentObject var downloadManager: DownloadManager
    @Binding var isDisplayed: Bool
    let movie: MovieDetailsResponse?
    
    var body: some View {
        ZStack {
            Color.PopupWithButtonView.background
                .ignoresSafeArea()
                .onTapGesture {
                    isDisplayed.toggle()
                }
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .foregroundColor(.PopupWithButtonView.mainViewBackground)
                VStack(spacing: 32.dvs) {
                    VStack(spacing: 16.dvs) {
                        Text("Download")
                            .font(.Urbanist.Bold.size(of: 24.dfs))
                            .foregroundColor(.PopupWithButtonView.titleText)
                        Text("Movies still downloading...\nPlease wait or hide the process")
                            .multilineTextAlignment(.center)
                            .font(.Urbanist.Regular.size(of: 16.dfs))
                            .foregroundColor(.PopupWithButtonView.subTitleText)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    HDeviderView()
                    VStack {
                        HStack {
                            if downloadManager.countOfBytesReceived != 0 {
                                Text("\(downloadManager.countOfBytesReceived.getSizeMB) / \(downloadManager.countOfBytesExpectedToReceive.getSizeMB)")
                            }
                            Spacer()
                            Text("\(downloadManager.progress.percent)%")
                                .font(.Urbanist.Bold.size(of: 14.dfs))
                                .foregroundColor(.ProgressPopUp.accentColor)
                        }
                        HStack(spacing: 4.dhs) {
                            ProgressView(value: downloadManager.progress, total: downloadManager.total)
                                .progressViewStyle(CustomProgressViewStyle(width: 252.dhs))
                                
                            Image("cross")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20.dhs, height: 20.dvs)
                                .opacity(downloadManager.countOfBytesExpectedToReceive != 0 ? 1 : 0)
                                .onTapGesture {
                                    if !viewModel.alreadyDownloaded(imageName: movie?.posterPath) {
                                        viewModel.cancelDownload(imageName: movie?.posterPath)
                                    }
                                    isDisplayed.toggle()
                                }
                        }
                    }
                    Button("Hide") {
                        isDisplayed.toggle()
                    }
                    .frame(height: 58.dvs, alignment: .center)
                    .buttonStyle(GrayButton())
                    Spacer()
                }
                .padding(.horizontal, 32.dhs)
                .padding(.top, 40.dvs)
            }
            .frame(width: 340.dhs, height: 363.dvs, alignment: .center)
            .onAppear {
                viewModel.setup(downloadManager)
            }
        }
        .opacity(isDisplayed ? 1 : 0)
        .animation(.easeIn(duration: 0.2))
    }
}

//struct ProgressPopUpView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProgressPopUpView(isDisplayed: .constant(true), movie: MovieDetailsResponse())
//    }
//}
