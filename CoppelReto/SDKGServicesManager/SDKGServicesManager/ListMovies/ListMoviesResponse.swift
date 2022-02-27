//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public struct ListMoviesResponse: Codable {

    public let page: Int?
    public let results: [DetailMovieResponse]?
    public let total_results: Int?
    public let total_pages: Int?
}
