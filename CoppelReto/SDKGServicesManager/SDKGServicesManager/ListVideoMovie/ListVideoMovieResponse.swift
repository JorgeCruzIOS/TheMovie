//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public struct ListVideoMovieResponse: Codable {
    
    public let id: Int?
    public let results: [VideoMovieDetailResponse]?
    
    public struct VideoMovieDetailResponse: Codable{
        public let iso_639_1: String?
        public let iso_3166_1: String?
        public let name: String?
        public let key: String?
        public let site: String?
        public let size: Int?
        public let type: String?
        public let official: Bool?
        public let id: String?
    }
}
