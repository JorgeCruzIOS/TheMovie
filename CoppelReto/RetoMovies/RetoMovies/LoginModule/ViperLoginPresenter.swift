//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

/// ViperLogin Module Presenter
class ViperLoginPresenter {
    
    weak var _view: ViperLoginViewProtocol?
    var interactor: ViperLoginInteractorProtocol?
    var wireframe: ViperLoginRouterProtocol?
   
}

// MARK: - extending ViperLoginPresenter to implement it's protocol
extension ViperLoginPresenter: ViperLoginPresenterProtocol {
    func requestLogin(email: String, credential: String) {
        _view?.notifyLoadingView()
        guard email != "", credential != "" else {
            _view?.notifyDissmisLoadingView()
            _view?.notifyErrorMessage(message: "Faltan campos por completar, verifica el correo electrónico y/o contraseña")
            return
        }
        interactor?.postLoginCredential(email: email, credential: credential)
    }
    
    func responseLogin() {
        _view?.notifyDissmisLoadingView()
        wireframe?.navigateToHomeModule(uinavigation: _view?.getContext())
    }
    
    func responseErrorMessage(message: String) {
        _view?.notifyDissmisLoadingView()
        _view?.notifyErrorMessage(message: message)
    }
    
    
}
