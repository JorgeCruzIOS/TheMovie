//
//  SplashScreen.swift
//  RetoMovies
//
//  Created by Dsi Soporte Tecnico on 28/02/22.
//

import UIKit
import FirebaseAuth

class SplashScreen: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            Auth.auth().languageCode = "es"
            if Auth.auth().currentUser != nil {
                self.navigationController?.pushViewController(TabHomeMain.createModule(), animated: true)
            } else {
                self.navigationController?.pushViewController(ViperLoginMain.createModule(), animated: true)
                
            }
            
        }
    }
}
