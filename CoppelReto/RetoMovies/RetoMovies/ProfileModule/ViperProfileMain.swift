
//  Created by Dsi Soporte Tecnico on 26/02/22.
//

import UIKit

internal class ViperProfileMain: NSObject {

    public static func createModule() -> UIViewController{
     
        let viewController  :   ViperProfileView?   =  ViperProfileView()
        if let view = viewController {
            let presenter   =   ViperProfilePresenter()
            let wireframe   =   ViperProfileRouter()
            let interactor  =   ViperProfileInteractor()
            
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
