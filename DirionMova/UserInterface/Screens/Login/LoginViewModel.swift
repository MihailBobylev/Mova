//
//  LoginViewModel.swift
//  DirionMova
//
//  Created by Юрий Альт on 05.10.2022.
//

import SwiftUI
import Alamofire
import Combine

class LoginViewModel: ObservableObject {
    typealias LoginCompletionBlock = ((Bool) -> Void)
    //MARK: - Binding Properties
    @Published var isUserLoginSuccess = false
    @Published var isTransparentBackgroundDisplayed = false
    @Published var userName = "DirionAndroid"
    @Published var password = "V.KZ5UtXMUHwwM!"
    @Published var errorMessage = ""
    @Published var formDataIsValid = false
    @Published var goToHomeScreen = false
    private var completionHandler: LoginCompletionBlock?
    
    //MARK: - Private Properties
    private let authService = DefaultAuthUseCase()
    private let networkReachabilityService = NetworkReachabilityManager()
    private let accountUseCase: AccountUseCase = DefaultAccountUseCase()
    private let storage = CredentialStorageImplementation()
    private var cancellableSet: Set<AnyCancellable> = []
    
    private var isUserNameValidPublisher: AnyPublisher<Bool, Never> {
        $userName
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map {
                $0.count > 2
            }
            .eraseToAnyPublisher()
    }
    
    private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .map {
                $0.count > 7
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest(isUserNameValidPublisher, isPasswordValidPublisher)
            .map { userNameIsValid, passwordIsValid in
                return userNameIsValid && passwordIsValid
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: DispatchQueue.main)
            .assign(to: \.formDataIsValid, on: self)
            .store(in: &cancellableSet)
    }
    
    //MARK: - Public Methods
    private func isNetworkReachable() -> Bool {
        networkReachabilityService?.isReachable ?? false
    }
    
    func auth() {
        login()
            .flatMap { [weak self] sessionId in
                (self?.getCreatedListInfo(sessionId: sessionId))!
            }
            .sink { completion in
                switch completion {
                case .finished:
                    print("@@@ Publisher is finished login()")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] value in
                self?.goToHomeScreen = value
            }
            .store(in: &cancellableSet)

    }
    
    
    
//    head // [Entity]
//        .flatMap { entities -> AnyPublisher<Entity, Error> in
//            Publishers.Sequence(sequence: entities)
//                .eraseToAnyPublisher()
//        }
//        .flatMap { entity -> AnyPublisher<Entity, Error> in
//            self.makeFuture(for: entity) // [Derivative]
//                .flatMap { derivatives -> AnyPublisher<Derivative, Error> in
//                    Publishers.Sequence(sequence: derivatives)
//                        .eraseToAnyPublisher()
//                }
//                .flatMap { derivative -> AnyPublisher<Derivative2, Error> in
//                    self.makeFuture(for: derivative)
//                        .eraseToAnyPublisher() // Derivative2
//                }
//                .collect()
//                .map { derivative2s -> Entity in
//                    self.configuredEntity(entity, from: derivative2s)
//                }
//                .eraseToAnyPublisher()
//        }
//        .collect()
    
    
    
    func login() -> AnyPublisher<String, Error> {
        Future { handler in
            self.authService.loginAndCreateSession(username: self.userName, password: self.password) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let sessionId):
                    self.isUserLoginSuccess = true
                    let feedbackGenerator = UINotificationFeedbackGenerator()
                    feedbackGenerator.notificationOccurred(.success)
                    handler(.success(sessionId))
                case .failure(let error):
                    self.completionFailed()
                    print(error)
                    self.showErrorMessage(for: error)
                    handler(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func showErrorMessage(for error: MovaError) {
        switch error.statusCode {
        case .loginFailure:
            errorMessage = "Invalid username and/or password"
        case .accountDisabled:
            errorMessage = "Account disabled: Your account is no longer active"
        case .emailVerificationFailure:
            errorMessage = "Email not verified: Your email address has not been verified"
        default:
            break
        }
        password = ""
        let feedbackGenerator = UINotificationFeedbackGenerator()
        feedbackGenerator.notificationOccurred(.error)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.errorMessage = ""
        }
    }
    
    func resetAllStates() {
        isTransparentBackgroundDisplayed = false
        isUserLoginSuccess = false
    }
    
    private func getCreatedListInfo(sessionId: String) -> AnyPublisher<Bool, Error>{
        Future { handler in
            self.accountUseCase.getCreatedList(sessionId: sessionId) { result in
                switch result {
                case .success(let success):
                    handler(.success(success))
                case .failure(let error):
                    handler(.failure(error))
                    print(error)
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension LoginViewModel {
    private func completionSucceed() {
        self.completionHandler?(true)
    }
    
    private func completionFailed() {
        self.isTransparentBackgroundDisplayed = false
        self.isUserLoginSuccess = false
        self.completionHandler?(false)
        errorMessage = ""
    }
}
