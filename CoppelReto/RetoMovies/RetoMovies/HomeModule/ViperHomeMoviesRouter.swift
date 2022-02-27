//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

/// ViperHomeMovies Module Router (aka: Wireframe)
internal class ViperHomeMoviesRouter {
    var module: ModuleFacadeHome?
}
    
extension ViperHomeMoviesRouter: ViperHomeMoviesRouterProtocol {
    func navigateToProfile(uinavigation: UINavigationController?) {
        uinavigation?.pushViewController(ViperProfileMain.createModule(), animated: true)
    }
    
    func navigateToLogin(uinavigation: UINavigationController?) {
        uinavigation?.popToRootViewController(animated: true)
    }
    
    func navigateToMovieDetailModule(uinavigation: UINavigationController?, idMovie:Int) {
        uinavigation?.pushViewController(ViperMovieDetailMain.createModule(module: module ?? .Movie, idMovie: idMovie), animated: true)
    }
}
