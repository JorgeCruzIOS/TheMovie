//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import SDKGCommonUtils

/// ViperProfile Module View
class ViperProfileView: UIViewController {
    
    private var ui : ViperProfileViewUI?
    var presenter: ViperProfilePresenterProtocol?
    
    override func loadView() {
        // setting the custom view as the view controller's view
        ui = ViperProfileViewUI(delegate: self)
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GColorSingleton.NoneSpaceColor
        presenter?.requestFavorites()
    }
    
}

// MARK: - extending ViperProfileView to implement it's protocol
extension ViperProfileView: ViperProfileViewProtocol {
    func onResponseFavorites(response: [MovieEntity]) {
        ui?.reload(result: response)
    }
    
    func onResquestLoading() {
        ui?.isLoadingOptions = true
        ui?.reload(result: [])
    }
    
    func onResponseLoading() {
        ui?.isLoadingOptions = false
    }
}

// MARK: - extending ViperProfileView to implement the custom ui view delegate
extension ViperProfileView: ViperProfileViewUIDelegate {
    func notifyReloadOnInitial() {
        presenter?.requestFavorites()
    }
    
    func fetchNavigationController() -> UINavigationController? {
        return navigationController
    }
}
