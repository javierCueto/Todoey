//
//  SceneDelegate.swift
//  Todoey
//
//  Created by José Javier Cueto Mejía on 27/11/19.
//  Copyright © 2019 José Javier Cueto Mejía. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("1")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("2")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("3")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
       print("4")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("6")
    }
    
    



}

