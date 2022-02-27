//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils

/// ViperLogin Module View
class ViperLoginView: UIViewController {
    
    private var ui : ViperLoginViewUI?
    var presenter: ViperLoginPresenterProtocol?
    
    override func loadView() {
        // setting the custom view as the view controller's view
        ui = ViperLoginViewUI(delegate: self)
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
}

// MARK: - extending ViperLoginView to implement it's protocol
extension ViperLoginView: ViperLoginViewProtocol {
    func getContext() -> UINavigationController? {
        return navigationController
    }
    
    func notifyLoadingView() {
        DispatchQueue.main.async {
            GLoader.show(parent: self.view)
        }
    }
    
    func notifyDissmisLoadingView() {
        DispatchQueue.main.async {
            GLoader.remove(parent: self.view)
        }
    }
    
    func notifyErrorMessage(message: String) {
        let alert = UIAlertController(title: "Información", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - extending ViperLoginView to implement the custom ui view delegate
extension ViperLoginView: ViperLoginViewUIDelegate {
    func notifyLoginWithCredential(email: String, credential: String) {
        presenter?.requestLogin(email: email, credential: credential)
    }
}
