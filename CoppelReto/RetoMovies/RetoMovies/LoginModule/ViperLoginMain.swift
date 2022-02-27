//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

internal class ViperLoginMain: NSObject {

    public static func createModule() -> UIViewController{
     
        let viewController  :   ViperLoginView?   =  ViperLoginView()
        if let view = viewController {
            let presenter   =   ViperLoginPresenter()
            let wireframe   =   ViperLoginRouter()
            let interactor  =   ViperLoginInteractor()
            
            view.presenter  =   presenter
            
            presenter._view          =   view
            presenter.interactor    =   interactor
            presenter.wireframe        =   wireframe
            
            interactor._presenter    =   presenter
            
            return view
        }
        
        return UIViewController()
    }
}
