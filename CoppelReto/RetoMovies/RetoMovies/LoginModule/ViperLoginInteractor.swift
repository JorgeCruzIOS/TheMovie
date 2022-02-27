//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import FirebaseAuth

/// ViperLogin Module Interactor
class ViperLoginInteractor{
    weak var _presenter : ViperLoginPresenterProtocol?
}

extension ViperLoginInteractor: ViperLoginInteractorProtocol {
    func postLoginCredential(email: String, credential: String) {
        Auth.auth().signIn(withEmail: email, password: credential) { [self] authResult, error in
            guard let _ = authResult else {
                _presenter?.responseErrorMessage(message: error?.localizedDescription ?? "Correo electrónico y/o contraseña invalidos")
                return
                
            }
            _presenter?.responseLogin()
        }
    }
    

}
