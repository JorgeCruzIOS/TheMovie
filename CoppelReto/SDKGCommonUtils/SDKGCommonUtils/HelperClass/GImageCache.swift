//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

open class GImageCache {
    static let shared = GImageCache()
    
    private let cache = NSCache<NSString, UIImage>()
    private var task = URLSessionDataTask()
    private var session = URLSession.shared
    
    public func imageFor(url: URL, completionHandler: @escaping (UIImage?,Error?) -> Void) {
        if let imageInCache = self.cache.object(forKey: url.absoluteString as NSString)  {
            completionHandler(imageInCache, nil)
            return
        }
        
        self.task = self.session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completionHandler(nil, error)
                return
            }
            
            let image = UIImage(data: data!)
            
            self.cache.setObject(image ?? UIImage(), forKey: url.absoluteString as NSString)
            completionHandler(image, nil)
        }
        
        self.task.resume()
    }
}
