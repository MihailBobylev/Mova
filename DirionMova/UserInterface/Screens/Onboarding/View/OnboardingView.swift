//
//  OnboardingView.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/6/22.
//

import SwiftUI

struct OnboardingView: View {
    @State private var isAnimationOne = true
    @State private var isAnimationTwo = false
    @State private var isAnimationThree = false
    @ObservedObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject var coordinator: ApplicationCoordinator<MovaFlowCoordinator>
    @State private var currentPage = 0
    @State private var isActive = false
    
    var body: some View {
            ZStack {
                ZStack {
                    Color(UIColor.MOVA.black)
                    backgroundImageOne
                    backgroundImageTwo
                    backgroundImageThree
                    gradientView
                }
                .ignoresSafeArea()
                VStack(spacing: 0) {
                    Spacer()
                    TabView(selection: $currentPage) {
                        ForEach(0..<viewModel.modelData.count, id: \.self) { index in
                            CardView(_title: viewModel.modelData[index].title,
                                     _description: viewModel.modelData[index].description)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    .overlay(customPageTab, alignment: .bottom)
                    .animation(.easeInOut(duration: 0.3))
                    .transition(.slide)
                    .onChange(of: currentPage, perform: { newValue in
                        switch newValue {
                        case 0:
                            isAnimationOne = true
                            isAnimationTwo = false
                            isAnimationThree = false
                        case 1:
                            isAnimationOne = false
                            isAnimationTwo = true
                            isAnimationThree = false
                        case 2:
                            isAnimationOne = false
                            isAnimationTwo = false
                            isAnimationThree = true
                            viewModel.turnOffNextLaunchOnboarding()
                        default: break
                        }
                    })
                    ZStack {
                        getStartedButton
                        skipButton
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true)
    }
}

extension OnboardingView {
    private var backgroundImageOne: some View {
        Image(viewModel.modelData[0].backgroundImage)
            .resizable()
            .scaleEffect(isAnimationOne ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.3))
    }
    private var backgroundImageTwo: some View {
        Image(viewModel.modelData[1].backgroundImage)
            .resizable()
            .scaleEffect(isAnimationTwo ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.3))
    }
    private var backgroundImageThree: some View {
        Image(viewModel.modelData[2].backgroundImage)
            .resizable()
            .scaleEffect(isAnimationThree ? 1.0 : 0.0)
            .animation(.easeInOut(duration: 0.3))
    }
    
    private var gradientView: some View {
        LinearGradient(gradient: Gradient(
            colors: [.clear, Color.SplashScreen.gradientMaxColor]),
                       startPoint: .top, endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
    
    private var getStartedButton: some View {
        Button("Get Started") {
            coordinator.show(.startView)
        }
        .opacity(currentPage == viewModel.modelData.count - 1 ? 1 : 0)
        .animation(.easeInOut)
        .frame(height: 58.dvs, alignment: .center)
        .buttonStyle(MovaButton())
        .padding([.leading, .trailing, .top], 24.dhs)
        .padding(.bottom, 36.dvs)
    }
    
    private var customPageTab: some View {
        HStack(spacing: 6.dhs) {
            ForEach(viewModel.modelData.indices, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color(UIColor.MOVA.red) : Color.white)
                    .frame(width: index == currentPage ? 32 : 8, height: 8)
            }
        }
    }
    
    private var skipButton: some View {
        HStack {
            Button(action: {
                viewModel.turnOffNextLaunchOnboarding()
                coordinator.show(.startView)
            }) {
                Text("Skip")
                    .font(.Urbanist.Bold.size(of: 24.dfs))
                    .foregroundColor(.white)
                    .padding([.leading], 32.dhs)
                    .opacity(currentPage < viewModel.modelData.count - 1 ? 1 : 0)
                    .animation(.easeInOut)
            }
            Spacer()
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
