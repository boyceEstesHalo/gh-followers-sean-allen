//
//  SceneDelegate.swift
//  GHFollowers
//
//  Created by Boyce Estes on 7/1/20.
//  Copyright © 2020 Boyce Estes. All rights reserved.
//

import UIKit

// This allows for multiwindow operations: You can have two instances of your app at the same time.
// These used to use windows but now it can be scenes.

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // similar to didFinishLaunching in appDelegate
        
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        // this function call will take care of setting up our basic hierarchy with tabs and nav controllers
        window?.rootViewController = GFTabBarController()
        window?.makeKeyAndVisible()
        
        // this will make all of our navigationbars have this configuration
        configureNavigationBar()
    }
    
    func configureNavigationBar() {
        print("configure")
        UINavigationBar.appearance().tintColor = .systemGreen
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

