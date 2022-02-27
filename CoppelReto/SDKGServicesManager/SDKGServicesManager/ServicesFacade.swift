//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils


public enum FilterFacadeMovie: Int{
    case Popular
    case TopRated
    case Upcoming
    case OnTheAir
    case NowPlaying
    case Lasted
    case AiringToday
    
    public func normativeName()->String{
        switch self{
        case .Popular:
            return "Popular"
        case .TopRated:
            return "Mejor calificado"
        case .Upcoming:
            return "Próximo"
        case .OnTheAir:
            return "En emisión"
        case .NowPlaying:
            return "En cartelera"
        case .Lasted:
            return "Mas reciente"
        case .AiringToday:
            return "Transmitiendo Hoy"
        }
    }
    
    public func endpointName()->String{
        switch self{
        case .Popular:
            return "popular"
        case .TopRated:
            return "top_rated"
        case .Upcoming:
            return "upcoming"
        case .OnTheAir:
            return "on_the_air"
        case .NowPlaying:
            return "now_playing"
        case .Lasted:
            return "latest"
        case .AiringToday:
            return "airing_today"
        }
    }
    
    public func fromHashValue(hashValue: Int) -> FilterFacadeMovie {
        switch hashValue{
        case 0:
            return .Popular
        case 1:
            return .TopRated
        case 2:
            return .Upcoming
        case 3:
            return .OnTheAir
        case 4:
            return .NowPlaying
        case 5:
            return .Lasted
        case 6:
            return .OnTheAir
        default:
            return .AiringToday
        }
    }
}

public enum ModuleFacadeHome: Int{
    case TV
    case Movie

    public func endpointName()->String{
        switch self{
        case .TV:
            return "tv"
        case .Movie:
            return "movie"
        }
    }
}

open class ServicesFacade {
    
    public static let shared = ServicesFacade()
    
    private var moviesList : ListMoviesService?
    private var movieListDetail : DetailMovieService?
    private var movieVideo : ListVideoMovieService?
   
    public func fetchList(module: ModuleFacadeHome, filter: FilterFacadeMovie,
                          success: @escaping (ListMoviesServiceProtocol.Response, String?)->Void,
                          empty: @escaping (String?)->Void,
                          failure: @escaping (String?) -> Void){
        
        moviesList = ListMoviesService(base: module.endpointName(), endPoint: filter.endpointName())
        moviesList?.fetch(params: BaseRequestEmpty(), success: { responseData, responseCode, responseMessage in
            success(responseData, responseMessage)
        }, empty: { responseMessage in
            empty(responseMessage)
        }, failure: { responseMessage in
            failure(responseMessage)
        })
    }
    
    public func fetchListDetail(module: ModuleFacadeHome, id: Int,
                          success: @escaping (DetailMovieServiceProtocol.Response, String?)->Void,
                          empty: @escaping (String?)->Void,
                          failure: @escaping (String?) -> Void){

        movieListDetail = DetailMovieService(base: module.endpointName(), endPoint: id)
        movieListDetail?.fetch(params: BaseRequestEmpty(), success: { responseData, responseCode, responseMessage in
            success(responseData, responseMessage)
        }, empty: { responseMessage in
            empty(responseMessage)
        }, failure: { responseMessage in
            failure(responseMessage)
        })
    }

    public func fetchDatailMovie(module: ModuleFacadeHome, filter: Int,
                          success: @escaping (ListVideoMovieServiceProtocol.Response, String?)->Void,
                          empty: @escaping (String?)->Void,
                          failure: @escaping (String?) -> Void){
        
        movieVideo = ListVideoMovieService(base: module.endpointName(), endPoint: filter)
        movieVideo?.fetch(params: BaseRequestEmpty(), success: { responseData, responseCode, responseMessage in
            success(responseData, responseMessage)
        }, empty: { responseMessage in
            empty(responseMessage)
        }, failure: { responseMessage in
            failure(responseMessage)
        })
    }
}
