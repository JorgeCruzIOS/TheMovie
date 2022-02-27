//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

/// ViperHomeMovies Module Presenter
///
internal class ViperHomeMoviesPresenter {
    
    weak var _view: ViperHomeMoviesViewProtocol?
    var interactor: ViperHomeMoviesInteractorProtocol?
    var wireframe: ViperHomeMoviesRouterProtocol?
    var filterHomeMovies: FilterFacadeMovie = .Popular
}

// MARK: - extending ViperHomeMoviesPresenter to implement it's protocol
extension ViperHomeMoviesPresenter: ViperHomeMoviesPresenterProtocol {
    func requestProfile() {
        wireframe?.navigateToProfile(uinavigation: _view?.getContext())
    }
    
    
    func requestLogout() {
        interactor?.fetchLogout()
        wireframe?.navigateToLogin(uinavigation: _view?.getContext())
    }
    
    func requestMovieDetailModule(idMovie:Int) {
        wireframe?.navigateToMovieDetailModule(uinavigation: _view?.getContext(), idMovie: idMovie)
    }
    
    func updateListFilterMovie(filter: FilterFacadeMovie) {
        filterHomeMovies = filter
    }
    
    func responseListMovies(result: ListMoviesServiceProtocol.Response) {
        _view?.onResponseLoading()
        _view?.onResponseListMovies(result: result)
    }
    
    func requestListMovies() {
        _view?.onResquestLoading()
        interactor?.getListMovies(filter: filterHomeMovies)
    }
    
    func responseServicesErrorMessage(message: String) {
        _view?.onResponseLoading()
        
    }
    
    
}
