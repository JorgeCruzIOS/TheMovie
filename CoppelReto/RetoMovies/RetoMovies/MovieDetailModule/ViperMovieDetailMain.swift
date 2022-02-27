//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

internal class ViperMovieDetailMain {
    
    public static func createModule(module: ModuleFacadeHome, idMovie:Int) -> UIViewController{
     
        let viewController  :   ViperMovieDetailView?   =  ViperMovieDetailView()
        if let view = viewController {
            let presenter   =   ViperMovieDetailPresenter()
            let wireframe   =   ViperMovieDetailRouter()
            let interactor  =   ViperMovieDetailInteractor()
            
            view.presenter  =   presenter
            view.idMovie    =   idMovie
            view.module     =   module
            presenter._view         =   view
            presenter.interactor    =   interactor
            presenter.wireframe     =   wireframe
            
            interactor._presenter   =   presenter
            interactor.module       = module
            
            return view
        }
        
        return UIViewController()
    }
}
