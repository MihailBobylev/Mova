//
//  SceneDelegate.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/19/22.
//

import SwiftUI

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
    private let storage: CredentialsStorage = CredentialStorageImplementation()
    private var coordinator: ApplicationCoordinator<MovaFlowCoordinator>?
    private var downloadManager: DownloadManager?
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        downloadManager = (UIApplication.shared.delegate as! AppDelegate).downloadManager
        guard let _downloadManager = downloadManager else { return }
        
        if storage.isFirstLaunch {
            coordinator = .init(startingRoute: .onboarding, downloadManager: _downloadManager)
        } else {
            if storage.guestSessionLastUpdate != nil {
                coordinator = .init(startingRoute: .home, downloadManager: _downloadManager)
            } else if storage.pinExists {
                coordinator = .init(startingRoute: .pin(flow: .enter), downloadManager: _downloadManager)
            } else if storage.isLoggedIn() {
                coordinator = .init(startingRoute: .home, downloadManager: _downloadManager)
            } else {
                coordinator = .init(startingRoute: .startView, downloadManager: _downloadManager)
            }
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = coordinator?.navigationController
        window?.makeKeyAndVisible()
        coordinator?.start()
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        downloadManager?.cancellAll()
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        downloadManager?.reloadViewsStates()
    }
}
