//
//  MovieEntity.swift
//  RetoMovies
//
//  Created by Dsi Soporte Tecnico on 26/02/22.
//

import UIKit

struct MovieEntity: Decodable {

    var id: Int?
    var type: Int?
    var title: String?
    var overview: String?
    var date: String?
    var poster_path: String?
}
