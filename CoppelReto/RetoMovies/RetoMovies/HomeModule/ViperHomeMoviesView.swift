//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils
import SDKGServicesManager

/// ViperHomeMovies Module View
internal class ViperHomeMoviesView: UIViewController {
    
    private var ui : ViperHomeMoviesViewUI?
    var presenter: ViperHomeMoviesPresenterProtocol?
    var module: ModuleFacadeHome?
    
    override func loadView() {
        // setting the custom view as the view controller's view
        ui = ViperHomeMoviesViewUI(delegate: self,module: module)
        view = ui
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = GColorSingleton.NoneSpaceColor
        presenter?.updateListFilterMovie(filter: .Popular)
        presenter?.requestListMovies()
    }
    
}

// MARK: - extending ViperHomeMoviesView to implement it's protocol
extension ViperHomeMoviesView: ViperHomeMoviesViewProtocol {
    func getContext() -> UINavigationController? {
        return navigationController
    }
    
    func onResponseListMovies(result: ListMoviesServiceProtocol.Response) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: { [self] in
            ui?.reload(result: result)
        })
    }
    
    func onResquestLoading() {
        ui?.isLoadingOptions = true
        ui?.reload(result: nil)
    }
    
    func onResponseLoading() {
        ui?.isLoadingOptions = false
    }
    
    private func logoutAction(){
        let alert = UIAlertController(title: "Información", message: "¿Estas seguro de cerrar tu sesión?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Si, cerrar mi sesión", style: .default, handler: {[self] _ in
            presenter?.requestLogout()
        }))
        alert.addAction(UIAlertAction(title: "En otro momento", style: .destructive, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - extending ViperHomeMoviesView to implement the custom ui view delegate
extension ViperHomeMoviesView: ViperHomeMoviesViewUIDelegate {
    func notifyMenuOptionSelected() {
        let alert = UIAlertController(title: "Opciones", message: "¿Que deseas hacer?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ver perfil", style: .default, handler: { [self] _ in
            presenter?.requestProfile()
        }))
        alert.addAction(UIAlertAction(title: "Cerrar Sesión", style: .destructive, handler: { [self] _ in
            logoutAction()
        }))
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func fetchNavigationController() -> UINavigationController? {
        return navigationController
    }
    
    func notifyMovieSelected(idMovie: Int) {
        presenter?.requestMovieDetailModule(idMovie: idMovie)
    }
    
    func notifyFilterChange(filter: FilterFacadeMovie) {
        presenter?.updateListFilterMovie(filter: filter)
        presenter?.requestListMovies()
    }
    
    func notifyReloadOnInitial() {
        presenter?.requestListMovies()
    }
}

