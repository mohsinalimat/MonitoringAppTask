//
//  APIRequest.swift
//  MonitoringList
//
//  Created by Anas Alhasani on 7/7/18.
//  Copyright © 2018 Anas Alhasani. All rights reserved.
//

import Foundation

protocol APIRequest: Encodable {
    
    associatedtype Response: Decodable
    
    var method: RequestMethod { get }
    
    var headers: HeadersDict { get }
    
    var resourceName: APIResourceName { get }
    
    func url(in apiClient: APIClient) -> URL
    
    func urlRequest(in apiClient: APIClient) -> URLRequest

}

extension APIRequest {
    
    var method: RequestMethod {
        return .post
    }
    
    var headers: HeadersDict {
        
        let credentials = String(
            format: "%@:%@",
            Credentials.username,
            Credentials.password
        )
        
        let data = credentials.data(using: .utf8) ?? Data()
        
        let credentialsBase64 = data.base64EncodedString()
        
        return [
            "Accept": "application/json",
            "Authorization": "Basic \(credentialsBase64)"
        ]
    }
    
    func url(in apiClient: APIClient) -> URL {
        switch method {
        case .get:
            let parameters = URLQueryEncoder.encode(self)
            
            let url = apiClient.configuration.url.appendingPathComponent(resourceName.rawValue)
            
            return URL(string: "\(url.absoluteString)?\(parameters)") ?? url
            
        case .post:
             return apiClient.configuration.url.appendingPathComponent(resourceName.rawValue)
        }
       
    }
    
    
    func urlRequest(in apiClient: APIClient) -> URLRequest {
        
        let requestURL = url(in: apiClient)
        
        let cachePolicy = apiClient.configuration.cachePolicy
        
        let timeout = apiClient.configuration.timeout
        
        var urlRequest = URLRequest(
            url: requestURL,
            cachePolicy: cachePolicy,
            timeoutInterval: timeout
        )
        
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        
        urlRequest.httpBody = method == .post ? try? encoder.encode(self): nil 
        
        return urlRequest
    }
}

