//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public extension UIImageView {

    func setImage(from url: URL, placeholder: UIImage? = nil) {
        image = placeholder
        GImageCache.shared.imageFor(url: url) { image, error  in
            if error == nil{
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
