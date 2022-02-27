//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

/// ViperMovieDetail Module Interactor
class ViperMovieDetailInteractor{
    let movieManagerServices = ServicesFacade.shared
    var _presenter: ViperMovieDetailPresenterProtocol?
    var module: ModuleFacadeHome?
    var databaseManager = DatabaseSingleton.shareInstance
}
    
extension ViperMovieDetailInteractor: ViperMovieDetailInteractorProtocol {
    func switchFavorite(model: MovieEntity) {
        if databaseManager.fetchFavoriteMovieById(id: model.id ?? 0){
            databaseManager.deleteFavoriteMovie(id: model.id ?? 0)
        }else{
            databaseManager.addFavoriteMovie(movie: model)
        }
       
    }
    
    func getFavoriteState(model: MovieEntity) {
        if databaseManager.fetchFavoriteMovieById(id: model.id ?? 0){
            _presenter?.responseFavoriteState(state: true)
        }else{
            _presenter?.responseFavoriteState(state: false)
        }
    }
    
    func getListVideoMovies(id: Int) {
        movieManagerServices.fetchDatailMovie(module:  module ?? .Movie, filter: id) { [self] (response, _) in
            DispatchQueue.main.async {
                _presenter?.responseListVideoMovies(result: response)
            }
        } empty: { [self] responseMessage in
            DispatchQueue.main.async {
                _presenter?.responseServicesErrorMessage(message: responseMessage ?? "")
            }
        } failure: { [self] responseMessage in
            DispatchQueue.main.async {
                _presenter?.responseServicesErrorMessage(message: responseMessage ?? "")
            }
        }

    }
    
    func getMovieDetail(id: Int) {
        
        movieManagerServices.fetchListDetail(module: module ?? .Movie, id: id) {  [self] (response, _) in
            DispatchQueue.main.async {
                _presenter?.responseMovieDetail(result: response)
            }
        } empty: { [self] responseMessage in
            DispatchQueue.main.async {
                _presenter?.responseServicesErrorMessage(message: responseMessage ?? "")
            }
        } failure: { [self] responseMessage in
            DispatchQueue.main.async {
                _presenter?.responseServicesErrorMessage(message: responseMessage ?? "")
            }
        }
    }
    
    
}
