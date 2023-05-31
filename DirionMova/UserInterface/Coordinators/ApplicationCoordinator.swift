//
//  ApplicationCoordinator.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/19/22.
//

import Foundation
import SwiftUI

class ApplicationCoordinator<Router: NavigationRouter>: Coordinator, ObservableObject {
    private let storage = CredentialStorageImplementation()
    let downloadManager: DownloadManager
    let navigationController: UINavigationController
    let startingRoute: Router?
    
    init(navigationController: AppNavigationController = .init(), startingRoute: Router? = nil, downloadManager: DownloadManager) {
        self.navigationController = navigationController
        self.startingRoute = startingRoute
        self.downloadManager = downloadManager
    }
    
    override func start() {
        guard let route = startingRoute else { return }
        self.show(route)
        showSplashScreen()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            debugPrint(self.navigationController.viewControllers.count)
            self.pop(animated: false)
        }
    }
}
  
extension ApplicationCoordinator {
    
    func show(_ route: Router, animated: Bool = true) {
        let view = route.view()
        let viewWithCoordinator = view.environmentObject(self).environmentObject(downloadManager)
        let viewController = UIHostingController(rootView: viewWithCoordinator)
        switch route.transition {
        case .push:
            navigationController.pushViewController(viewController, animated: animated)
        case .presentModally:
            viewController.modalPresentationStyle = .formSheet
            navigationController.present(viewController, animated: animated)
        case .presentFullscreen:
            viewController.modalPresentationStyle = .fullScreen
            navigationController.present(viewController, animated: animated)
        }
    }
    
    func pop(animated: Bool = true) {
        navigationController.popViewController(animated: animated)
    }
    
    func popToRoot(animated: Bool = true) {
        navigationController.popToRootViewController(animated: animated)
    }
    
    func popTo(viewsToPop: Int, animated: Bool = true) {
        if navigationController.viewControllers.count > viewsToPop {
            let vc = navigationController.viewControllers[navigationController.viewControllers.count - viewsToPop - 1]
            navigationController.popToViewController(vc, animated: animated)
        }
    }
    
    func logout() {
        storage.clearStorage()
        downloadManager.clearMovaDownloads()
        let view = StartView()
        let viewWithCoordinator = view.environmentObject(self)
        let vc = UIHostingController(rootView: viewWithCoordinator)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func dismiss(animated: Bool = true) {
        navigationController.dismiss(animated: animated) { [weak self] in
            self?.navigationController.viewControllers = []
        }
    }
    
    private func showSplashScreen() {
        let view = SplashScreenView()
        let viewWithCoordinator = view.environmentObject(self)
        let vc = UIHostingController(rootView: viewWithCoordinator)
        navigationController.pushViewController(vc, animated: false)
    }
}
