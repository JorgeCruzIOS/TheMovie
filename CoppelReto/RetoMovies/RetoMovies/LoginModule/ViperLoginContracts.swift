//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

protocol ViperLoginViewProtocol: AnyObject {
    func notifyLoadingView()
    func notifyDissmisLoadingView()
    func notifyErrorMessage(message: String)
    func getContext()->UINavigationController?
}

//MARK: Interactor -
/// ViperLogin Module Interactor Protocol
protocol ViperLoginInteractorProtocol: AnyObject {
   func postLoginCredential(email: String, credential: String)
}

//MARK: Presenter -
/// ViperLogin Module Presenter Protocol
protocol ViperLoginPresenterProtocol: AnyObject {
  
    func requestLogin(email: String, credential: String)
    func responseLogin()
    func responseErrorMessage(message: String)
}

//MARK: Router (aka: Wireframe) -
/// ViperLogin Module Router Protocol
protocol ViperLoginRouterProtocol: AnyObject {
    func navigateToHomeModule(uinavigation: UINavigationController?)
}
