//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

open class GLoader {
    
    private static let tagView = -123456789
    
    public static func show(parent: UIView) {
        if parent.viewWithTag(tagView) != nil {
            return
        }
        parent.isUserInteractionEnabled = false
        let mainView = UIView(frame: (parent.frame))
        mainView.backgroundColor = .black.withAlphaComponent(0.75)
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mainView.tag = tagView
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.center = parent.center
        activityIndicator.startAnimating()
        mainView.addSubview(activityIndicator)
        parent.addSubview(mainView)
    }
    
    public static func remove(parent: UIView) {
        parent.isUserInteractionEnabled = true
        if let loaderView = parent.viewWithTag(tagView) {
            loaderView.removeFromSuperview()
        }
    }
    
}
