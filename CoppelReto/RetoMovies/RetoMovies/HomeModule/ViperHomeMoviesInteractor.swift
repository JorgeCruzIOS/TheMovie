//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import FirebaseAuth
import SDKGServicesManager

/// ViperHomeMovies Module Interactor
internal class ViperHomeMoviesInteractor{
    let movieManagerServices = ServicesFacade.shared
    var _presenter: ViperHomeMoviesPresenterProtocol?
    var module: ModuleFacadeHome?
}
    
extension ViperHomeMoviesInteractor:ViperHomeMoviesInteractorProtocol {
    func fetchLogout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func getListMovies(filter: FilterFacadeMovie) {
        
        movieManagerServices.fetchList(module: module ?? .Movie, filter: filter) { [self] (response, _) in
            DispatchQueue.main.async {
                _presenter?.responseListMovies(result: response)
            }
        } empty: { [self] responseMessage in
            DispatchQueue.main.async {
                _presenter?.responseServicesErrorMessage(message: responseMessage ?? "")
            }
        } failure: {[self] responseMessage in
            DispatchQueue.main.async {
                _presenter?.responseServicesErrorMessage(message: responseMessage ?? "")
            }
        }
    }

}
