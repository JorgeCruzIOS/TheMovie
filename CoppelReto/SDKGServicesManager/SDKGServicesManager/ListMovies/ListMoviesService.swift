//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import SDKGCommonUtils

public protocol ListMoviesServiceProtocol{
    typealias Request = BaseRequestEmpty?
    typealias Response = ListMoviesResponse?
}

internal class ListMoviesService:ListMoviesServiceProtocol {
    private var servicesManager = GServicesSingleton.shareManager
    private var rootPath : String = ""
    private var basePath : String = ""
    private var endpoint : String = ""
    
    init(base:String, endPoint: String){
        rootPath = "https://api.themoviedb.org/3"
        basePath = "/\(base)"
        endpoint = "/\(endPoint)"
    }
    
    func fetch(params: Request,
                      success: @escaping (Response, Int?, String?) -> Void,
                      empty:   @escaping (String?)->Void,
                      failure: @escaping (String?) -> Void) {
        
        var paramsBuilder = [URLQueryItem]()
        for case let (label?, value) in Mirror(reflecting: params!)
                .children.map({ ($0.label, $0.value) }) {
            paramsBuilder.append(URLQueryItem(name: label, value: value as? String))
        }
        paramsBuilder.append(URLQueryItem(name: "language", value: "es-MX"))
        servicesManager.getServices(
            method: .GET,
            route: "\(rootPath)\(basePath)\(endpoint)",
            params: paramsBuilder,
            auth: "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmYTdkYmE0N2Q3OWY2NDliNGZhNjUyM2U0MDU3OWEwNSIsInN1YiI6IjU4ZmEyODNmOTI1MTQxNTg3MzAwY2Q4ZCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.MEDDAiPdtCYaM7M8woxf7HdLMGvC7jiMdO3djtFVauA") { [self] ( response, responseCode, responseMessage) in
                switch responseCode{
                case 200,201:
                    guard let response = response, let responseModel = servicesManager.decode(JSONObject: response, entity: Response.self) else{
                        failure("No se pudo obtener una respuesta valida")
                        return
                    }
                    success(responseModel, responseCode, responseMessage)
                    break
                case 400:
                    guard let response = response, let responseModel = servicesManager.decode(JSONObject: response, entity: BaseResponse400.self) else{
                        failure("No se pudo obtener una respuesta valida")
                        return
                    }
                    failure(responseModel.status_message ?? "No se pudo obtener una respuesta valida")
                    break
                default:
                    failure("Review code \(responseCode)")
                    break
                }
                
            } failure: { _, responseMessage in
                failure(responseMessage)
            }
    }
}

