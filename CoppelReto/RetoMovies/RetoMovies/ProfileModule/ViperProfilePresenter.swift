//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

/// ViperProfile Module Presenter
class ViperProfilePresenter {
    
    weak var _view: ViperProfileViewProtocol?
    var interactor: ViperProfileInteractorProtocol?
    var wireframe: ViperProfileRouterProtocol?
    
}

// MARK: - extending ViperProfilePresenter to implement it's protocol
extension ViperProfilePresenter: ViperProfilePresenterProtocol {
    func requestFavorites() {
        _view?.onResquestLoading()
        interactor?.fetchFavorites()
    }
    
    func responseFavorites(response: [MovieEntity]) {
        _view?.onResponseLoading()
        _view?.onResponseFavorites(response: response)
    }
    
    
}
