//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGServicesManager

internal protocol ViperHomeMoviesViewProtocol: AnyObject {
    func onResquestLoading()
    func onResponseLoading()
    func onResponseListMovies(result:ListMoviesServiceProtocol.Response)
    func getContext()->UINavigationController?
}

//MARK: Interactor -
/// ViperHomeMovies Module Interactor Protocol
internal protocol ViperHomeMoviesInteractorProtocol: AnyObject {
    func getListMovies(filter: FilterFacadeMovie)
    func fetchLogout()
}

//MARK: Presenter -
/// ViperHomeMovies Module Presenter Protocol
internal protocol ViperHomeMoviesPresenterProtocol: AnyObject {
    func updateListFilterMovie(filter: FilterFacadeMovie)
    func requestLogout()
    func requestProfile()
    func requestMovieDetailModule(idMovie:Int)
    func requestListMovies()
    func responseListMovies(result: ListMoviesServiceProtocol.Response)
    func responseServicesErrorMessage(message: String)
}

//MARK: Router (aka: Wireframe) -
/// ViperHomeMovies Module Router Protocol
internal protocol ViperHomeMoviesRouterProtocol: AnyObject {
    func navigateToMovieDetailModule(uinavigation: UINavigationController?, idMovie:Int)
    func navigateToProfile(uinavigation: UINavigationController?)
    func navigateToLogin(uinavigation: UINavigationController?)
}
