//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

internal class TabHomeMain {
    public static func createModule() -> UITabBarController{
        let tabbar  :   TabHome?   =  TabHome()
        if let view = tabbar {
            return view
        }
        return UITabBarController()
    }
}
