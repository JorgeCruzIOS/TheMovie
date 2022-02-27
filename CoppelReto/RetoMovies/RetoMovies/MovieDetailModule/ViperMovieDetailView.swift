//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils
import SDKGServicesManager

/// ViperMovieDetail Module View
class ViperMovieDetailView: UIViewController {
    
    private var ui : ViperMovieDetailViewUI?
    var idMovie: Int?
    var module: ModuleFacadeHome?
    var presenter: ViperMovieDetailPresenterProtocol?
    override func loadView() {
        // setting the custom view as the view controller's view
        ui = ViperMovieDetailViewUI(delegate: self)
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GColorSingleton.NoneSpaceColor
        guard let id = idMovie else{
            return
        }
        presenter?.requestMovieDetail(id: id)
        presenter?.requestListVideoMovies(id: id)
    }
    
}

// MARK: - extending ViperMovieDetailView to implement it's protocol
extension ViperMovieDetailView: ViperMovieDetailViewProtocol {
    func onResponseFavoriteState(state: Bool) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseInOut, .curveEaseOut]) { [self] in
            ui?.favoriteButton.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        } completion: { [self] _ in
            ui?.favoriteButton.setImage(UIImage(named: state == false ? "favorite_border_ic" : "favorite_ic", in: .local_common_utils, compatibleWith: nil), for: .normal)
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut, .curveEaseOut]) {
                ui?.favoriteButton.transform = CGAffineTransform(scaleX: 1, y: 1)
            } completion: {_ in }
            
        }
    }
    
    func onResponseVideoMovies(result: ListVideoMovieServiceProtocol.Response) {
        guard let results = result?.results?.first else{
            return
        }
        ui?.onLoadVideo(key: results.key ?? "")
    }
    
    func onResquestLoading() {
        
    }
    
    func onResponseLoading() {
        
    }
    
    func onResponseDetailMovie(result: DetailMovieServiceProtocol.Response) {
        ui?.onLoadInformation(information: result)
        presenter?.requestFavoriteState(model: MovieEntity(id: result?.id, type: module == .Movie ? 1 : 2, title: result?.title, overview: result?.overview, date: module == .Movie ? result?.release_date : result?.first_air_date, poster_path: result?.poster_path))
    }
    
    func getContext() -> UINavigationController? {
        return navigationController
    }
    
    
}

// MARK: - extending ViperMovieDetailView to implement the custom ui view delegate
extension ViperMovieDetailView: ViperMovieDetailViewUIDelegate {
    func fetchModule() -> ModuleFacadeHome {
        return module ?? .Movie
    }
    
    func fetchCurrentFavoriteState(model: MovieEntity) {
        presenter?.requestSwitchFavorite(model: model)
        presenter?.requestFavoriteState(model: model)
    }
    
    func fetchNavigationController() -> UINavigationController? {
        return navigationController
    }
    
    
}
