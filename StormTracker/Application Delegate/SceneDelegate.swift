//
//  SceneDelegate.swift
//  StormTracker
//
//  Created by waheedCodes on 04/05/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        if let rootViewController = windowScene.windows.first?.rootViewController as? RootViewController {
            let locationManager = LocationManager()
            let rootViewModel = RootViewModel(locationService: locationManager)
            rootViewController.viewModel = rootViewModel
        }
        
    }
}
