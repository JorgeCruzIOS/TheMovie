//  Created Dsi Soporte Tecnico on 26/02/22.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
import UIKit
import Foundation
import OSLog

public enum HTTPMethod: String{
    case POST = "POST"
    case GET = "GET"
}

extension OSLog {
    private static var subsystem = Bundle.main.bundleIdentifier!
    static let apiManager = OSLog(subsystem: subsystem, category: "GServicesSingleton")
}

open class GServicesSingleton: NSObject {

    public static var shareManager = GServicesSingleton()
    
    public func getServices(
        method  : HTTPMethod = .GET,
        route   : String,
        params: [URLQueryItem] = [URLQueryItem](),
        auth: String = "",
        success: @escaping (_ response: Data?, _ responseCode: Int,_  responseMessage: String) -> Void,
        failure: @escaping (_ responseCode: Int,_  responseMessage: String) -> Void)
    {
        let session = configurationRequest()
        let url = paramsRequest(url: route, params: params)
        
        os_log("URL: %{uri}@", log: OSLog.apiManager, type: OSLogType.debug, url.absoluteURL as CVarArg)
        let request = headerRequest(url: url, method: method, authorization: auth)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 500 {
                failure(response.statusCode, "Error de servidor")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                failure((response as? HTTPURLResponse)?.statusCode ?? 500, error?.localizedDescription ?? "Error de servidor")
                return
            }
            success(data, response.statusCode, "")
        }
        task.resume()
        
    }
    
    public func postServices<K : Codable>(
        method  : HTTPMethod = .POST,
        route   : String,
        body  : K,
        auth: String = "",
        success: @escaping (_ response: Data?, _ responseCode: Int,_  responseMessage: String) -> Void,
        failure: @escaping (_ responseCode: Int,_  responseMessage: String) -> Void)
    {

        let session = configurationRequest()
        guard let url = URL(string: route) else{
            return
        }
        
        os_log("URL: %{uri}@", log: OSLog.apiManager, type: OSLogType.debug, url.absoluteURL as CVarArg)
        var request = headerRequest(url: url, method: method, authorization: auth)
        request = bodyRequest(urlrequest: request as! NSMutableURLRequest, body: body)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse, response.statusCode == 500 {
                failure(response.statusCode, "Error de servidor")
                return
            }
            guard let data = data, let response = response as? HTTPURLResponse else {
                failure((response as? HTTPURLResponse)?.statusCode ?? 500, error?.localizedDescription ?? "")
                return
            }
            success(data, response.statusCode, "")
            
        }
        task.resume()
    }
    
}

extension GServicesSingleton{
    public func encode<T:Codable> (object: T) -> ([String: Any]){
        
        let objectJSON = try! JSONEncoder().encode(object)
        let jsonObject = try! JSONSerialization.jsonObject(with: objectJSON, options: [])
        let data       = jsonObject as? [String: Any] ?? [:]
        return data
    }
      
    public func decode<T:Decodable> (JSONObject: Data, entity : T.Type) -> (T?){
        let objectdecoded   = try? JSONDecoder().decode(T.self, from: JSONObject)
        return objectdecoded
    }
    
    public func decodeDictionary<T:Decodable> (JSONObject: [String: Any], entity : T.Type) -> (T){
        
        let objectJSON      = try! JSONSerialization.data(withJSONObject: JSONObject, options: [])
        let objectdecoded   = try! JSONDecoder().decode(T.self, from: objectJSON)
        
        return objectdecoded
    }
    
  
}

extension GServicesSingleton: URLSessionDelegate{
    
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential, credential);
    }
    
    private func configurationRequest()->URLSession{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 10.0
        return URLSession(configuration: sessionConfig, delegate: self, delegateQueue:  nil)
    }
    
    private func headerRequest(url:URL,method:HTTPMethod,authorization: String = "")->URLRequest{
        var request: URLRequest = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if authorization != ""{
            request.setValue("Bearer \(authorization)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = method.rawValue
        return request
    }
    
    private func bodyRequest<K: Codable>(urlrequest: NSMutableURLRequest, body: K)->URLRequest{
        let json = self.encode(object: body)
        let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        urlrequest.httpBody = data
        return urlrequest as URLRequest
    }
    
    private func paramsRequest(url:String, params: [URLQueryItem])->URL{
        var urlFormat = URLComponents(string: url)
        urlFormat?.queryItems = params
        return (urlFormat?.url)!
    }
}
