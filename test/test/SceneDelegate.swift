//
//  SceneDelegate.swift
//  test
//
//  Created by Alina Tytarenko on 09.05.2022.
//

import UIKit
import SwiftUI
import ComposableArchitecture

private var appStore = Store(
    initialState: Table.State(mode: Table.Mode.idle, list: []),
    reducer: Table.reducer,
    environment: Table.Environment(apiClient: ListAPIClient.live)
)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let appView = TableViewController(store: appStore)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let rootViewController =  UINavigationController(rootViewController: appView)
            window.rootViewController = rootViewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

