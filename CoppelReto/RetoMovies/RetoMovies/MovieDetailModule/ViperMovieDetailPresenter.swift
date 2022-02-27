//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

/// ViperMovieDetail Module Presenter
class ViperMovieDetailPresenter {
    
    weak var _view: ViperMovieDetailViewProtocol?
    var interactor: ViperMovieDetailInteractorProtocol?
    var wireframe: ViperMovieDetailRouterProtocol?
}

// MARK: - extending ViperMovieDetailPresenter to implement it's protocol
extension ViperMovieDetailPresenter: ViperMovieDetailPresenterProtocol {
    func requestSwitchFavorite(model: MovieEntity) {
        interactor?.switchFavorite(model: model)
    }
    
    func requestFavoriteState(model: MovieEntity) {
        interactor?.getFavoriteState(model: model)
    }
    
    func responseFavoriteState(state: Bool) {
        _view?.onResponseFavoriteState(state: state)
    }
    
    func responseListVideoMovies(result: ListVideoMovieServiceProtocol.Response) {
        _view?.onResponseLoading()
        _view?.onResponseVideoMovies(result: result)
    }
    
    func requestListVideoMovies(id: Int) {
        _view?.onResquestLoading()
        interactor?.getListVideoMovies(id: id)
    }
    
    func responseMovieDetail(result: DetailMovieServiceProtocol.Response) {
        _view?.onResponseLoading()
        _view?.onResponseDetailMovie(result: result)
    }
    
    func requestMovieDetail(id: Int) {
        _view?.onResponseLoading()
        interactor?.getMovieDetail(id: id)
    }
    
    func responseServicesErrorMessage(message: String) {
        _view?.onResponseLoading()
    }
    
    
}
