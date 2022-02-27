//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils
import SDKGServicesManager

internal class TabHome: UITabBarController {

    private var leftViewBar: NSLayoutConstraint = NSLayoutConstraint()
    lazy var viewBar: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 2
        view.backgroundColor = GColorSingleton.LabelColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    var tabBarList = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .clear
        tabBar.tintColor = GColorSingleton.LabelColor
        tabBar.unselectedItemTintColor = GColorSingleton.LabelColor.withAlphaComponent(0.53)
        let viewcustom = UIView(frame: tabBar.frame)
        viewcustom.backgroundColor = GColorSingleton.WhiteColor
        viewcustom.layer.cornerRadius = 15
        viewcustom.layer.shadowRadius = 7
        viewcustom.layer.shadowOffset = CGSize(width: 0, height: 2)
        viewcustom.layer.shadowOpacity = 1
        viewcustom.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.12)
        viewcustom.translatesAutoresizingMaskIntoConstraints = false
        
        tabBar.addSubview(viewcustom)
        viewcustom.addSubview(viewBar)
        NSLayoutConstraint.activate([
            viewcustom.heightAnchor.constraint(equalTo: tabBar.heightAnchor,constant: 25),
            viewcustom.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            viewcustom.rightAnchor.constraint(equalTo: tabBar.rightAnchor),
            viewcustom.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor,constant: 20),
            
            viewBar.heightAnchor.constraint(equalToConstant: 4.0),
            viewBar.widthAnchor.constraint(equalToConstant: 60),
            viewBar.bottomAnchor.constraint(equalTo: viewcustom.topAnchor, constant: 4)
        ])
        
        leftViewBar = NSLayoutConstraint(item: viewBar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: viewcustom, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
        leftViewBar.isActive = true
       
        let widthFrame = (self.view.bounds.width / 2)
        self.leftViewBar.constant = (widthFrame / 2) - 30
    
        let homeMoviesModule = ViperHomeMoviesMain.createModule(module: .Movie)
        homeMoviesModule.tabBarItem = UITabBarItem(title: "Peliculas", image: UIImage(named: "movies_home_ic", in: Bundle.local_common_utils, compatibleWith: nil), selectedImage:  UIImage(named: "movies_home_ic", in: Bundle.local_common_utils, compatibleWith: nil))
        homeMoviesModule.tabBarItem.tag = 100

        let homeSeriesModule = ViperHomeMoviesMain.createModule(module: .TV)
        homeSeriesModule.tabBarItem = UITabBarItem(title: "Series", image:UIImage(named: "series_home_ic", in: Bundle.local_common_utils, compatibleWith: nil) , selectedImage: UIImage(named: "series_home_ic", in: Bundle.local_common_utils, compatibleWith: nil))
        homeSeriesModule.tabBarItem.tag = 101
        
        tabBarList.append(homeMoviesModule)
        tabBarList.append(homeSeriesModule)
        viewControllers = tabBarList
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let widthFrame = (self.view.bounds.width / 2)
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut]) {
            switch item.tag {
            case 100:
                self.leftViewBar.constant = (widthFrame / 2) - 30
                break
            case 101:
                self.leftViewBar.constant = widthFrame + (widthFrame / 2) - 30
                break
            default:
                break
            }
            self.view.layoutIfNeeded()
        } completion: { (isAnimated) in }
        
    }
}
