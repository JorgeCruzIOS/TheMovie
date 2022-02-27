
//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// ViperProfile Module View Protocol
protocol ViperProfileViewProtocol: AnyObject {
    func onResquestLoading()
    func onResponseLoading()
    func onResponseFavorites(response: [MovieEntity])
}

//MARK: Interactor -
/// ViperProfile Module Interactor Protocol
protocol ViperProfileInteractorProtocol: AnyObject {
    func fetchFavorites()
}

//MARK: Presenter -
/// ViperProfile Module Presenter Protocol
protocol ViperProfilePresenterProtocol: AnyObject {
    func requestFavorites()
    func responseFavorites(response: [MovieEntity])
}

//MARK: Router (aka: Wireframe) -
/// ViperProfile Module Router Protocol
protocol ViperProfileRouterProtocol: AnyObject {
   
}
