//
//  NavigationRouter.swift
//  DirionMova
//
//  Created by ~Akhtamov on 10/19/22.
//

import SwiftUI

enum NavigationTransitionStyle {
    case push
    case presentModally
    case presentFullscreen
}

protocol NavigationRouter {
    
    associatedtype V: View
    var transition: NavigationTransitionStyle { get }
    
    @ViewBuilder
    func view() -> V
}
