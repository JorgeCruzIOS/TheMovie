//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

internal class ViperHomeMoviesMain {
    
    public static func createModule(module: ModuleFacadeHome) -> UIViewController{
     
        let viewController  :   ViperHomeMoviesView?   =  ViperHomeMoviesView()
        if let view = viewController {
            let presenter   =   ViperHomeMoviesPresenter()
            let wireframe   =   ViperHomeMoviesRouter()
            let interactor  =   ViperHomeMoviesInteractor()
            
            view.presenter  =   presenter
            view.module = module
            
            presenter._view          =   view
            presenter.interactor    =   interactor
            presenter.wireframe        =   wireframe
            
            interactor._presenter    =   presenter
            interactor.module = module
            
            wireframe.module = module
            
            return view
        }
        
        return UIViewController()
    }
}
