//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit

public struct DetailMovieResponse: Codable {

    public let poster_path: String?
    public let adult: Bool?
    public let overview: String?
    public let release_date: String?
    public let first_air_date: String?
    public let id: Int?
    public let original_title: String?
    public let original_language: String?
    public let title: String?
    public let name: String?
    public let backdrop_path: String?
    public let popularity: Double?
    public let vote_count: Int?
    public let video: Bool?
    public let vote_average: Float?
    public let runtime: Int?
    public let genres: [Genres]?
    
    public struct Genres: Codable{
        public let id: Int?
        public let name: String?
    }
}
