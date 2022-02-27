//
//  AppDelegate.swift
//  RetoMovies
//
//  Created by Dsi Soporte Tecnico on 26/02/22.
//

//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        setupIQKeyboard()
        let navigation = UINavigationController()
        navigation.isNavigationBarHidden = true
        Auth.auth().languageCode = "es"
        if Auth.auth().currentUser != nil {
            let rootHome = TabHomeMain.createModule()
            initRootViewController(rootHome, navigation: navigation)
            setRootViewController(navigation, animated: true)
        } else {
            let rootHome = ViperLoginMain.createModule()
            initRootViewController(rootHome, navigation: navigation)
            setRootViewController(navigation, animated: true)
        }
        
        return true
    }
    
    private func initRootViewController(_ vc: UIViewController, duration: CFTimeInterval = 0.3, navigation: UINavigationController) {
       // navigation.addTransition( duration: duration)
        navigation.viewControllers.removeAll()
        navigation.pushViewController(vc, animated: false)
    }
    
    private func setupIQKeyboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 50.0
    }
    
    private func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController  = nil
            self.window?.rootViewController = vc
            self.window?.backgroundColor = .white
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController  = nil
        window.rootViewController = vc
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }

}

