//
//  MovaFlowCoordinator.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/19/22.
//

import SwiftUI
import AVFoundation

enum MovaFlowCoordinator: NavigationRouter {
    case pin(flow: PinFlow)
    case login
    case onboarding
    case home
    case notification
    case startView
    case movieDetails(movieId: Int)
    case createAccount
    case interests
    case profile
    case selectResetContact
    case enterResetCode(type: ResetContactType, text: String)
    case enterNewPass
    case actionMenu(type: MoviesGroupType, tabSelected: Binding<String>)
    case explore
    case biometric
    case player(movieID: String)
    case editProfile
    case download
    case subscribeToPremium
    case payment(rate: SubscribeToPremiumType)
    case addNewCard(paymentViewModel: PaymentViewModel)
    case reviewSummary(rate: SubscribeToPremiumType, mocard: Mocard)
    case helpCenter
    case loadPlayer(name: String, title: String)
    case notificationSettings
    case privacyPolicy
    case security
    case language(language: Binding<String>)
    
    var transition: NavigationTransitionStyle {
        switch self {
        case .pin, .login, .onboarding, .home, .notification,
                .startView, .movieDetails, .createAccount, .interests, .profile,
                .selectResetContact, .enterResetCode, .enterNewPass, .explore,
                .player, .download, .subscribeToPremium, .payment, .addNewCard,
                .reviewSummary, .helpCenter, .notificationSettings, .privacyPolicy,
                .security, .language, .loadPlayer:
            return .push
        case .actionMenu, .biometric, .editProfile:
            return .push
        }
    }
    
    @ViewBuilder
    public func view() -> some View {
        switch self {
        case .pin(let flow):
            PinView(viewModel: .init(pinFlow: flow))
        case .login:
            LoginView()
        case .onboarding:
            OnboardingView()
        case .home:
            HomeTabView()
        case .notification:
            NotificationView()
        case .startView:
            StartView()
        case .movieDetails(let movieId):
            MovieDetailsView(viewModel: .init(movieId: movieId))
        case .createAccount:
            CreateAccountView()
        case .interests:
            InterestScreen()
        case .profile:
            ProfileView()
        case .selectResetContact:
            SelectResetContactView()
        case .enterResetCode(let type, let text):
            EnterResetCodeView(type: type, text: text)
        case .enterNewPass:
            EnterNewPasswordView()
        case .actionMenu(let type, let selected):
            ActionMenuView(actionMenuType: type, tabSelection: selected)
        case .explore:
            ExploreView(hideTabBar: .constant(false), bottomEdge: 40.0)
        case .biometric:
            BiometricView(viewModel: BiometricViewModel())
        case .player(let movieID):
            PlayerView(playerViewModel: .init(movieId: movieID))
        case .editProfile:
            EditProfileView()
        case .download:
            ProfileDownloads()
        case .subscribeToPremium:
            SubscribeToPremiumView()
        case .payment(let rate):
            PaymentView(rate: rate)
        case .addNewCard(let paymentViewModel):
            AddNewCardView(paymentViewModel: paymentViewModel)
        case .reviewSummary(let rate, let mocard):
            ReviewSummaryView(rate: rate, mocard: mocard)
        case .helpCenter:
            HelpCenterView()
        case .loadPlayer(let name, let title):
            LoadPlayerView(name: name, originalTitle: title)
        case .notificationSettings:
            NotificationSettingsView()
        case .privacyPolicy:
            PrivacyPolicyView()
        case .security:
            SecurityView()
        case .language(let language):
            LanguageView(selectedLanguage: language)
        }
    }
}
