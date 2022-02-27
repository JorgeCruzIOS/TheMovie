
//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils

/// ViperProfile Module Interactor
class ViperProfileInteractor{
    weak var _presenter: ViperProfilePresenterProtocol?
    private var databaseManager = DatabaseSingleton.shareInstance
    private var servicesManager = GServicesSingleton.shareManager
}
extension ViperProfileInteractor: ViperProfileInteractorProtocol {
    func fetchFavorites() {
        let movies: [MovieEntity] = databaseManager.fetchFavoriteMovie().compactMap { element in
            let ob = element as? [String:Any] ?? [:]
            let models = servicesManager.decodeDictionary(JSONObject: ob, entity: MovieEntity.self)
            return models
        }
        _presenter?.responseFavorites(response: movies)
    }
    

}
