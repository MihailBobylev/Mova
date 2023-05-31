//
//  Coordinator.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/19/22.
//

import SwiftUI

protocol BaseCoordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func addDependency(_ coordinator: Coordinator)
    func removeDependency(_ coordinator: Coordinator?)
    
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: AppNavigationController { get }
}

extension BaseCoordinator {
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: Coordinator?) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

class Coordinator: NSObject, BaseCoordinator {
    func start() {
        fatalError("must be implemented")
    }
    
    var childCoordinators: [Coordinator] = []
}

