//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

protocol ViperMovieDetailViewProtocol: AnyObject {
    func onResquestLoading()
    func onResponseLoading()
    func onResponseDetailMovie(result: DetailMovieServiceProtocol.Response)
    func onResponseVideoMovies(result: ListVideoMovieServiceProtocol.Response)
    func onResponseFavoriteState(state: Bool)
    func getContext()->UINavigationController?
}

//MARK: Interactor -
/// ViperMovieDetail Module Interactor Protocol
protocol ViperMovieDetailInteractorProtocol: AnyObject {
    func getMovieDetail(id: Int)
    func getListVideoMovies(id: Int)
    func getFavoriteState(model: MovieEntity)
    func switchFavorite(model: MovieEntity)
}

//MARK: Presenter -
/// ViperMovieDetail Module Presenter Protocol
protocol ViperMovieDetailPresenterProtocol: AnyObject {
    func requestMovieDetail(id:Int)
    func responseMovieDetail(result: DetailMovieServiceProtocol.Response)
    func requestFavoriteState(model: MovieEntity)
    func responseFavoriteState(state: Bool)
    func requestSwitchFavorite(model: MovieEntity)
    func requestListVideoMovies(id:Int)
    func responseListVideoMovies(result: ListVideoMovieServiceProtocol.Response)
    
    func responseServicesErrorMessage(message: String)
}

//MARK: Router (aka: Wireframe) -
/// ViperMovieDetail Module Router Protocol
protocol ViperMovieDetailRouterProtocol:AnyObject {
   
}
