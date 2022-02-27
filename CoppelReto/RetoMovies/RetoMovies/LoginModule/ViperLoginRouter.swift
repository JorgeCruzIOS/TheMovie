//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

/// ViperLogin Module Router (aka: Wireframe)
class ViperLoginRouter: ViperLoginRouterProtocol {
    
    func navigateToHomeModule(uinavigation: UINavigationController?) {
        let rootHome = TabHomeMain.createModule()
        uinavigation?.pushViewController(rootHome, animated: true)
    }
}
